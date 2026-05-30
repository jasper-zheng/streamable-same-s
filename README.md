# streamable-same-s

Export the **SAME-S** music autoencoder to a TorchScript `.ts` for the
[`nn~`](https://github.com/acids-ircam/nn_tilde) external (Max/MSP, PureData), with
**click-free real-time streaming baked in**. The exported model exposes three nn~ methods:
`forward` (audio round-trip), `encode` (audio → latents), `decode` (latents → audio).

This is the focused export layer extracted from the Stable Audio 3 repo. It contains a clean,
TorchScript-scriptable reimplementation of SAME-S plus the cached-streaming nn~ wrapper, and
reuses [`stable-audio-3`](https://github.com/Stability-AI/stable-audio-3) only to load the
pretrained weights.

## Install

Requires a local checkout of `stable-audio-3` next to this repo (see `[tool.uv.sources]` in
`pyproject.toml`; swap to a git source to share).

```bash
uv sync
```

## Export

```bash
# default device auto-selects mps/cuda/cpu; use --device cpu for the most portable artifact
uv run streamable-same-s-export --device cpu --validate --out same_s.ts
```

Then load `same_s.ts` in an `nn~` object in Max/MSP and pick a method.

To export a **naive, zero-latency** model instead — each buffer processed independently, simpler
but with audible **clicks** at buffer seams — pass `--no-streaming`:

```bash
uv run streamable-same-s-export --device cpu --no-streaming --out same_s_naive.ts
```

## How it works

The production SAME model is not `torch.jit.script`-able (flash-/flex-attention branches,
`**kwargs`, varlen `Dict` metadata, `torch.utils.checkpoint`, einops). So
[`same_s_ts.py`](streamable_same_s/same_s_ts.py) reimplements the SAME-S math single-path with
TorchScript-safe ops only; it is numerically faithful to the original (decode bit-exact, encode
~100 dB SNR) and loads the same weights via
[`load.py`](streamable_same_s/load.py) (which uses stable-audio-3's `load_autoencoder`).

`nn~` calls the model on independent fixed buffers, which for a non-causal transformer would
click at every seam. [`nn_tilde_wrapper.py`](streamable_same_s/nn_tilde_wrapper.py) bakes in
**causal fixed-latency overlap-save**: each call runs one pass over `[cached real context | new
buffer]` and emits only the validated central region, with state kept in registered buffers.

## nn~ usage notes

| Method | in → out | nn~ ratios (in/out) | latency |
|---|---|---|---|
| `forward` | audio (2) → audio (2) | 1 / 1 | `2*right` frames |
| `encode`  | audio (2) → latents (256) | 1 / 4096 | `right` frames |
| `decode`  | latents (256) → audio (2) | 4096 / 1 | `right` frames |

- **Buffer size must be a multiple of 8192 samples** (2 latent frames — the model's chunk-fold
  alignment). 8192, 16384, … work; 4096 does **not**.
- **Latency.** Defaults `--left 2 --right 2`: encode/decode add ~186 ms, round-trip ~372 ms, plus
  the nn~ buffer. Inherent to the 4096× compression with frozen weights. The first `right`
  (encode/decode) or `2*right` (forward) frames of output are warmup fill — expected, not an artefact.
- **Precision/device.** fp32 (~413 MB); runs on CPU/CUDA/MPS. Export with `--device cpu` for the
  most portable artifact.

## Development

```bash
uv run --extra dev pytest        # network-free smoke test (no checkpoint needed)
```
