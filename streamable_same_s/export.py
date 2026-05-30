"""Export SAME-S to a TorchScript `.ts` for the nn~ (Max/MSP) external.

Builds the scriptable SAME-S reimplementation (`streamable_same_s.same_s_ts`), loads the
pretrained weights (via stable-audio-3's loader), wraps it with baked-in cached streaming
(`StreamingSAMETS`) so per-buffer nn~ calls are click-free, and writes a `.ts` that
exposes `forward` / `encode` / `decode`.

    streamable-same-s-export --out same_s.ts
    streamable-same-s-export --device cpu --left 2 --right 2 --validate

nn~ buffer size must be a multiple of 8192 samples (2 latent frames). Round-trip latency
is `2*right` latent frames (+ the nn~ buffer); encode/decode latency is `right` frames.
"""

from __future__ import annotations

import argparse

import torch

from streamable_same_s.load import load_same_s_ts
from streamable_same_s.nn_tilde_wrapper import StreamingSAMETS


def _pick_device(requested: str | None) -> str:
    if requested is not None:
        return requested
    if torch.backends.mps.is_available():
        return "mps"
    if torch.cuda.is_available():
        return "cuda"
    return "cpu"


def _validate(wrap: StreamingSAMETS, spl: int, device: str) -> None:
    """Stream a real-ish signal and report continuity vs a single-pass run."""
    core = wrap.core
    audio = torch.randn(1, 2, spl * 60, device=device) * 0.1

    def run(method, data, step):
        outs = []
        for s in range(0, data.shape[-1], step):
            c = data[..., s : s + step]
            if c.shape[-1] != step:
                break
            outs.append(method(c))
        return torch.cat(outs, dim=-1)

    def snr(a, b):
        n = min(a.shape[-1], b.shape[-1])
        a, b = a[..., :n].float(), b[..., :n].float()
        return 10 * torch.log10(a.pow(2).mean() / ((a - b).pow(2).mean() + 1e-20)).item()

    with torch.inference_mode():
        full = core.forward(audio)
        wrap.reset_cache()
        streamed = run(wrap.forward, audio, 2 * spl)
    lag = wrap.forward_latency_frames
    warm = 4
    steady = snr(full[..., warm * spl :], streamed[..., (lag + warm) * spl :])
    print(f"  forward steady-state SNR vs single-pass: {steady:.1f} dB")
    print(f"  round-trip latency: {lag} frames ({lag * spl / 44100 * 1000:.0f} ms) + nn~ buffer")


def main() -> None:
    ap = argparse.ArgumentParser()
    ap.add_argument("--out", default="same_s_nntilde.ts")
    ap.add_argument("--model", default="same-s")
    ap.add_argument("--device", default=None, help="mps | cuda | cpu (default: auto). Use cpu for the most portable nn~ artifact.")
    ap.add_argument("--left", type=int, default=2, help="left-context latent frames (even)")
    ap.add_argument("--right", type=int, default=2, help="lookahead latent frames (even); drives latency")
    ap.add_argument("--no-streaming", action="store_true", help="naive per-buffer export: zero added latency, but clicks at buffer seams")
    ap.add_argument("--validate", action="store_true")
    args = ap.parse_args()

    device = _pick_device(args.device)
    print(f"Loading {args.model} on {device} ...")
    core, ae = load_same_s_ts(device=device, model=args.model)
    spl = int(ae.downsampling_ratio)

    left, right = args.left, args.right
    if args.no_streaming:
        left = right = 0
        print("--no-streaming: naive per-buffer export (zero added latency, expect clicking at buffer seams)")

    wrap = StreamingSAMETS(
        core,
        sample_rate=ae.sample_rate,
        downsampling_ratio=spl,
        left=left,
        right=right,
        test_device=device,
    ).to(device).eval()

    if args.validate:
        print("Validating streaming continuity ...")
        _validate(wrap, spl, device)
        wrap.reset_cache()

    print(f"Scripting and saving to {args.out} ...")
    wrap.export_to_ts(args.out)
    print(
        f"Done. nn~ methods: forward/encode/decode. Buffer size must be a multiple of "
        f"{2 * spl} samples. encode/decode latency {right} frames, "
        f"round-trip {2 * right} frames."
    )


if __name__ == "__main__":
    main()
