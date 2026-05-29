"""nn~ (Max/MSP) wrapper for SAME-S with baked-in click-free streaming.

`nn~` calls `encode`/`decode`/`forward` on independent fixed-size buffers. The non-causal
SAME transformer would click at every buffer seam (edges seen against silence), so we bake
**causal fixed-latency overlap-save** into the scripted module (the cached_conv idea, but
for an attention model): each call runs ONE model pass over `[cached real context | new
buffer]` and emits only the validated central region, lagged by `right` lookahead frames.

State (one cache per stage) lives in registered buffers updated in place across calls — no
zero padding except during warmup. encode/decode output is delayed by `right` latent frames;
`forward` composes the two stages, so its latency is `2*right` frames.

Constraints (frozen weights): windows align to ALIGN=2 latent frames, so the nn~ buffer
size must be a multiple of 8192 samples (2 frames). `left`/`right` are even frame counts.
"""

from __future__ import annotations

import torch

from .nn_tilde import Module
from .same_s_ts import ALIGN, IO_CHANNELS, LATENT_DIM, SAMESCore


class StreamingSAMETS(Module):
    """Scriptable, stateful SAME-S for nn~. Register `encode`/`decode`/`forward`."""

    def __init__(
        self,
        core: SAMESCore,
        sample_rate: int = 44100,
        downsampling_ratio: int = 4096,
        left: int = 2,
        right: int = 2,
        test_device: str = "cpu",
    ):
        super().__init__()
        if left % ALIGN != 0 or right % ALIGN != 0:
            raise ValueError(f"left/right must be multiples of ALIGN={ALIGN}")
        self.core = core
        self.spl = int(downsampling_ratio)
        self.io_channels = IO_CHANNELS
        self.latent_dim = LATENT_DIM
        self.left = left
        self.right = right
        self.pad = left + right  # context frames carried across calls

        # One cache per stage, in that stage's INPUT units. Batch 1 by default;
        # reallocated on the fly if nn~ calls with a different batch. `forward`
        # composes encode then decode, so it reuses these two caches (no third).
        self.register_buffer("enc_cache", torch.zeros(1, IO_CHANNELS, self.pad * self.spl))
        self.register_buffer("dec_cache", torch.zeros(1, LATENT_DIM, self.pad))

        audio_labels = ["(signal) Channel %d" % d for d in range(1, IO_CHANNELS + 1)]
        latent_labels = ["(signal) Latent %d" % d for d in range(1, LATENT_DIM + 1)]
        self.register_method(
            "forward", in_channels=IO_CHANNELS, in_ratio=1, out_channels=IO_CHANNELS,
            out_ratio=1, input_labels=audio_labels, output_labels=audio_labels,
            test_method=False, test_device=test_device,
        )
        self.register_method(
            "encode", in_channels=IO_CHANNELS, in_ratio=1, out_channels=LATENT_DIM,
            out_ratio=self.spl, input_labels=audio_labels, output_labels=latent_labels,
            test_method=False, test_device=test_device,
        )
        self.register_method(
            "decode", in_channels=LATENT_DIM, in_ratio=self.spl, out_channels=IO_CHANNELS,
            out_ratio=1, input_labels=latent_labels, output_labels=audio_labels,
            test_method=False, test_device=test_device,
        )

    @torch.jit.export
    def encode(self, x: torch.Tensor) -> torch.Tensor:
        # x: (B, 2, b*spl) audio -> (B, 256, b) latents, lagged by `right` frames.
        cache = self.enc_cache
        if cache.shape[0] != x.shape[0]:
            cache = torch.zeros(
                x.shape[0], self.io_channels, self.pad * self.spl,
                dtype=x.dtype, device=x.device,
            )
        win = torch.cat((cache.to(x.dtype), x), dim=-1)
        lat = self.core.encode(win)  # (B, 256, pad + b)
        b = x.shape[-1] // self.spl
        emit = lat[..., self.left:self.left + b]
        self.enc_cache = win[..., win.shape[-1] - self.pad * self.spl:].clone()
        return emit

    @torch.jit.export
    def decode(self, z: torch.Tensor) -> torch.Tensor:
        # z: (B, 256, b) latents -> (B, 2, b*spl) audio, lagged by `right` frames.
        cache = self.dec_cache
        if cache.shape[0] != z.shape[0]:
            cache = torch.zeros(
                z.shape[0], self.latent_dim, self.pad,
                dtype=z.dtype, device=z.device,
            )
        win = torch.cat((cache.to(z.dtype), z), dim=-1)
        audio = self.core.decode(win)  # (B, 2, (pad + b) * spl)
        b = z.shape[-1]
        emit = audio[..., self.left * self.spl:(self.left + b) * self.spl]
        self.dec_cache = win[..., win.shape[-1] - self.pad:].clone()
        return emit

    def forward(self, x: torch.Tensor) -> torch.Tensor:
        # Round-trip = compose the two streaming stages so decode always sees
        # fully-finalised latents (a single-window round-trip would feed decode the
        # encoder's imperfect edge latents). Latency is 2*right frames.
        return self.decode(self.encode(x))

    def reset_cache(self) -> None:
        self.enc_cache = torch.zeros_like(self.enc_cache)
        self.dec_cache = torch.zeros_like(self.dec_cache)

    @property
    def encode_latency_frames(self) -> int:
        return self.right

    @property
    def forward_latency_frames(self) -> int:
        return 2 * self.right
