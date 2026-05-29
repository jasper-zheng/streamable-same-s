"""TorchScript-friendly reimplementation of the SAME-S autoencoder.

The production SAME model (`stable_audio_3/models/`) is not `torch.jit.script`-able: its
attention uses ``**kwargs``, conditional flash-/flex-attention globals, varlen ``Dict``
metadata, ``torch.utils.checkpoint`` and einops string patterns. This module reimplements
exactly the SAME-S forward math with a single code path and TorchScript-safe ops only
(``reshape``/``permute``/``transpose``/``cat``/slicing + ``F.scaled_dot_product_attention``),
so it can be scripted and exported for the ``nn~`` (Max/MSP) external.

The numerics mirror the validated MLX port
(`optimized/mlx/models/defs/same_s_{encoder,decoder}.py`), which in turn reproduces the
original PyTorch model. Weights are copied in from a loaded `AudioAutoencoder` by
`stable_audio_3.export.load.load_same_s_ts` — this file defines architecture only.

SAME-S constants (from `same-s-model_config.json`): dim 768, 6 blocks, 12 heads × 64,
RoPE over the first 32 head dims, differential attention, DyT norms, stride 16,
chunk_size 32 (→ effective_chunk 34, midpoint shift 17), latent_dim 256, patch_size 256,
2 audio channels. Softnorm bottleneck is folded into encode/decode (noise disabled).
"""

from __future__ import annotations

import torch
import torch.nn.functional as F
from torch import nn

# --- architecture constants (SAME-S) ---
DIM = 768
NUM_HEADS = 12
HEAD_DIM = 64
ROPE_DIMS = 32
NUM_BLOCKS = 6
FF_INNER = 2304  # ff_mult = 3
LATENT_DIM = 256
IO_CHANNELS = 2
PATCH_SIZE = 256
IN_CHANNELS = IO_CHANNELS * PATCH_SIZE  # 512, pretransform output
STRIDE = 16
SUB_CHUNK = STRIDE + 1  # 17 (S real + 1 query token)
CHUNK_SIZE = 32
EFFECTIVE_CHUNK = CHUNK_SIZE + CHUNK_SIZE // STRIDE  # 34
SHIFT = EFFECTIVE_CHUNK // 2  # 17
ALIGN = CHUNK_SIZE // STRIDE  # 2 latent frames
ROPE_BASE = 10000.0


def _rotate_half(x: torch.Tensor) -> torch.Tensor:
    # GPT-NeoX style: split the rotary block in two halves (matches the original
    # transformer.py rotate_half and MLX rope(traditional=False)).
    d = x.shape[-1] // 2
    x1 = x[..., :d]
    x2 = x[..., d:]
    return torch.cat((-x2, x1), dim=-1)


class DyT(nn.Module):
    """Dynamic Tanh: gamma * tanh(alpha * x) + beta."""

    def __init__(self, dim: int):
        super().__init__()
        self.alpha = nn.Parameter(torch.ones(1))
        self.gamma = nn.Parameter(torch.ones(dim))
        self.beta = nn.Parameter(torch.zeros(dim))

    def forward(self, x: torch.Tensor) -> torch.Tensor:
        return self.gamma * torch.tanh(self.alpha * x) + self.beta


class DifferentialAttention(nn.Module):
    """Differential self-attention: SDPA(q,k,v) - SDPA(q_diff,k_diff,v).

    `to_qkv` chunk(5) order matches the original: q, k, v, q_diff, k_diff.
    Per-head DyT q/k-norm, RoPE on the first ROPE_DIMS head dims, no bias.
    """

    def __init__(self):
        super().__init__()
        self.num_heads = NUM_HEADS
        self.head_dim = HEAD_DIM
        self.rope_dims = ROPE_DIMS
        self.dim = DIM
        self.to_qkv = nn.Linear(DIM, 5 * DIM, bias=False)
        self.to_out = nn.Linear(DIM, DIM, bias=False)
        self.q_norm = DyT(HEAD_DIM)
        self.k_norm = DyT(HEAD_DIM)
        self.scale = HEAD_DIM ** -0.5
        inv_freq = 1.0 / (
            ROPE_BASE ** (torch.arange(0, ROPE_DIMS, 2).float() / ROPE_DIMS)
        )
        self.register_buffer("inv_freq", inv_freq, persistent=False)

    def _rope_cos_sin(self, seq_len: int, device: torch.device, dtype: torch.dtype):
        t = torch.arange(seq_len, device=device).float()
        freqs = torch.outer(t, self.inv_freq)  # (N, ROPE_DIMS/2)
        freqs = torch.cat((freqs, freqs), dim=-1)  # (N, ROPE_DIMS)
        cos = freqs.cos().to(dtype).unsqueeze(0).unsqueeze(0)  # (1,1,N,ROPE_DIMS)
        sin = freqs.sin().to(dtype).unsqueeze(0).unsqueeze(0)
        return cos, sin

    def _apply_rope(self, x: torch.Tensor, cos: torch.Tensor, sin: torch.Tensor):
        rot = x[..., :self.rope_dims]
        passthrough = x[..., self.rope_dims:]
        rot = rot * cos + _rotate_half(rot) * sin
        return torch.cat((rot, passthrough), dim=-1)

    def _heads(self, t: torch.Tensor, b: int, n: int) -> torch.Tensor:
        return t.reshape(b, n, self.num_heads, self.head_dim).permute(0, 2, 1, 3)

    def forward(self, x: torch.Tensor) -> torch.Tensor:
        b = x.shape[0]
        n = x.shape[1]
        qkv = self.to_qkv(x)
        chunks = qkv.chunk(5, dim=-1)
        q = self._heads(chunks[0], b, n)
        k = self._heads(chunks[1], b, n)
        v = self._heads(chunks[2], b, n)
        q_diff = self._heads(chunks[3], b, n)
        k_diff = self._heads(chunks[4], b, n)

        q = self.q_norm(q)
        k = self.k_norm(k)
        q_diff = self.q_norm(q_diff)
        k_diff = self.k_norm(k_diff)

        cos, sin = self._rope_cos_sin(n, x.device, x.dtype)
        q = self._apply_rope(q, cos, sin)
        k = self._apply_rope(k, cos, sin)
        q_diff = self._apply_rope(q_diff, cos, sin)
        k_diff = self._apply_rope(k_diff, cos, sin)

        out_main = F.scaled_dot_product_attention(q, k, v, scale=self.scale)
        out_diff = F.scaled_dot_product_attention(q_diff, k_diff, v, scale=self.scale)
        out = out_main - out_diff

        out = out.permute(0, 2, 1, 3).reshape(b, n, self.dim)
        return self.to_out(out)


class GLUFeedForward(nn.Module):
    """SwiGLU feedforward: proj_out(value * silu(gate)), inner = FF_INNER."""

    def __init__(self):
        super().__init__()
        self.glu_proj = nn.Linear(DIM, FF_INNER * 2, bias=True)
        self.proj_out = nn.Linear(FF_INNER, DIM, bias=True)

    def forward(self, x: torch.Tensor) -> torch.Tensor:
        x = self.glu_proj(x)
        value, gate = x.chunk(2, dim=-1)
        return self.proj_out(value * F.silu(gate))


class TransformerBlock(nn.Module):
    def __init__(self):
        super().__init__()
        self.pre_norm = DyT(DIM)
        self.attn = DifferentialAttention()
        self.ff_norm = DyT(DIM)
        self.ff = GLUFeedForward()

    def forward(self, x: torch.Tensor) -> torch.Tensor:
        x = x + self.attn(self.pre_norm(x))
        x = x + self.ff(self.ff_norm(x))
        return x


class _ChunkedTransformer(nn.Module):
    """The 6 SAME-S blocks run with chunked attention + midpoint shift.

    Input/output: (B, internal_T, DIM) where internal_T is a multiple of
    EFFECTIVE_CHUNK and internal_T + 2*SHIFT is too (guaranteed when the latent
    length is a multiple of ALIGN).
    """

    def __init__(self):
        super().__init__()
        self.effective_chunk = EFFECTIVE_CHUNK
        self.shift = SHIFT
        self.blocks_first = nn.ModuleList([TransformerBlock() for _ in range(NUM_BLOCKS // 2)])
        self.blocks_second = nn.ModuleList([TransformerBlock() for _ in range(NUM_BLOCKS - NUM_BLOCKS // 2)])

    def forward(self, x: torch.Tensor) -> torch.Tensor:
        b = x.shape[0]
        internal_t = x.shape[1]
        d = x.shape[2]
        eff = self.effective_chunk
        shift = self.shift

        # First half: standard chunk boundaries.
        nc1 = internal_t // eff
        x = x.reshape(b * nc1, eff, d)
        for blk in self.blocks_first:
            x = blk(x)
        x = x.reshape(b, internal_t, d)

        # Second half: pad half a chunk on each side, re-chunk with offset boundaries.
        left = x[:, :shift, :]
        right = x[:, internal_t - shift:, :]
        x = torch.cat((left, x, right), dim=1)
        t2 = internal_t + 2 * shift
        nc2 = t2 // eff
        x = x.reshape(b * nc2, eff, d)
        for blk in self.blocks_second:
            x = blk(x)
        x = x.reshape(b, t2, d)
        x = x[:, shift:t2 - shift, :]
        return x


class SAMESCore(nn.Module):
    """Scriptable SAME-S: encode (audio -> latents) and decode (latents -> audio).

    Both methods operate on a whole, alignment-correct window (latent length a multiple
    of ALIGN = 2). Streaming/buffering is layered on top by the nn~ wrapper.
    """

    def __init__(self):
        super().__init__()
        self.patch_size = PATCH_SIZE
        self.io_channels = IO_CHANNELS
        self.in_channels = IN_CHANNELS
        self.stride = STRIDE
        self.dim = DIM
        self.sub_chunk = SUB_CHUNK
        # Encoder
        self.enc_mapping = nn.Linear(IN_CHANNELS, DIM, bias=True)  # 1x1 conv as Linear
        self.enc_new_tokens = nn.Parameter(torch.zeros(1, 1, DIM))
        self.enc_transformer = _ChunkedTransformer()
        self.enc_project_out = nn.Linear(DIM, LATENT_DIM, bias=True)
        # Decoder
        self.dec_project_in = nn.Linear(LATENT_DIM, DIM, bias=True)
        self.dec_new_tokens = nn.Parameter(torch.zeros(1, 1, DIM))
        self.dec_transformer = _ChunkedTransformer()
        self.dec_mapping = nn.Conv1d(DIM, IN_CHANNELS, kernel_size=3, padding=1, bias=True)
        # Softnorm bottleneck (auto_scale -> scalar running_std)
        self.scaling_factor = nn.Parameter(torch.ones(1, LATENT_DIM, 1))
        self.sn_bias = nn.Parameter(torch.zeros(1, LATENT_DIM, 1))
        self.running_std = nn.Parameter(torch.ones(1), requires_grad=False)

    # --- patching pretransform (pure reshape) ---
    def _patch(self, audio: torch.Tensor) -> torch.Tensor:
        # (B, 2, T) -> (B, 512, T/256)
        b = audio.shape[0]
        t = audio.shape[2]
        lp = t // self.patch_size
        x = audio.reshape(b, self.io_channels, lp, self.patch_size)
        x = x.permute(0, 1, 3, 2)  # (B, 2, 256, L)
        return x.reshape(b, self.in_channels, lp)

    def _unpatch(self, x: torch.Tensor) -> torch.Tensor:
        # (B, 512, L) -> (B, 2, L*256)
        b = x.shape[0]
        lp = x.shape[2]
        x = x.reshape(b, self.io_channels, self.patch_size, lp)
        x = x.permute(0, 1, 3, 2)  # (B, 2, L, 256)
        return x.reshape(b, self.io_channels, lp * self.patch_size)

    def encode(self, audio: torch.Tensor) -> torch.Tensor:
        # audio: (B, 2, T), T a multiple of 4096 with T/4096 a multiple of ALIGN.
        x = self._patch(audio)  # (B, 512, T_aud)  where T_aud = T/256
        b = x.shape[0]
        t_aud = x.shape[2]
        x = x.transpose(1, 2)  # (B, T_aud, 512)
        x = self.enc_mapping(x)  # (B, T_aud, 768)

        t_lat = t_aud // self.stride
        x = x.reshape(b * t_lat, self.stride, self.dim)
        nt = self.enc_new_tokens.expand(b * t_lat, 1, self.dim)
        x = torch.cat((x, nt), dim=1)  # (.,17,768)
        x = x.reshape(b, t_lat * self.sub_chunk, self.dim)

        x = self.enc_transformer(x)

        x = x.reshape(b * t_lat, self.sub_chunk, self.dim)
        x = x[:, self.sub_chunk - 1:self.sub_chunk, :]  # the query token output
        x = x.reshape(b, t_lat, self.dim)

        x = self.enc_project_out(x)  # (B, T_lat, 256)
        x = x.transpose(1, 2)  # (B, 256, T_lat)

        # softnorm encode
        x = x * self.scaling_factor + self.sn_bias
        x = x / self.running_std
        return x

    def decode(self, latents: torch.Tensor) -> torch.Tensor:
        # latents: (B, 256, T_lat), T_lat a multiple of ALIGN.
        x = latents * self.running_std  # softnorm decode (noise disabled)
        b = x.shape[0]
        t_lat = x.shape[2]
        x = x.transpose(1, 2)  # (B, T_lat, 256)
        x = self.dec_project_in(x)  # (B, T_lat, 768)

        x = x.reshape(b * t_lat, 1, self.dim)  # context token
        nt = self.dec_new_tokens.expand(b * t_lat, self.stride, self.dim)  # 16 query tokens
        x = torch.cat((x, nt), dim=1)  # (.,17,768)
        x = x.reshape(b, t_lat * self.sub_chunk, self.dim)

        x = self.dec_transformer(x)

        x = x.reshape(b * t_lat, self.sub_chunk, self.dim)
        x = x[:, 1:self.sub_chunk, :]  # drop context, keep the 16 query outputs
        x = x.reshape(b, t_lat * self.stride, self.dim)

        x = x.transpose(1, 2)  # (B, 768, T_lat*16)
        x = self.dec_mapping(x)  # (B, 512, T_lat*16)
        return self._unpatch(x)  # (B, 2, T_lat*4096)

    def forward(self, audio: torch.Tensor) -> torch.Tensor:
        return self.decode(self.encode(audio))
