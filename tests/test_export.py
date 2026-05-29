"""Network-free smoke test: build -> script -> save -> reload -> run.

Uses a randomly-initialised SAMESCore (no HF checkpoint needed), so it verifies
scriptability and the nn~ method contract without downloading weights.
"""

import torch

from streamable_same_s import SAMESCore, StreamingSAMETS

SPL = 4096
BUF = 2 * SPL  # smallest valid nn~ buffer (2 latent frames)


def _build():
    core = SAMESCore()
    return StreamingSAMETS(core, downsampling_ratio=SPL, left=2, right=2).eval()


def test_scripts_and_reloads(tmp_path):
    wrap = _build()
    scripted = torch.jit.script(wrap)
    assert scripted.get_methods() == ["forward", "encode", "decode"]
    path = tmp_path / "model.ts"
    scripted.save(str(path))
    reloaded = torch.jit.load(str(path))
    assert reloaded.get_methods() == ["forward", "encode", "decode"]


def test_nn_tilde_contract():
    wrap = _build()
    x = torch.randn(1, 2, BUF) * 0.1
    with torch.inference_mode():
        # forward: audio -> audio, same length
        assert tuple(wrap.forward(x).shape) == (1, 2, BUF)
        wrap.reset_cache()
        # encode: BUF samples -> BUF/SPL latents
        assert tuple(wrap.encode(x).shape) == (1, 256, BUF // SPL)
        # decode: 2 latents -> 2*SPL samples
        assert tuple(wrap.decode(torch.randn(1, 256, 2) * 0.1).shape) == (1, 2, BUF)


def test_state_persists_across_calls():
    wrap = _build()
    x = torch.ones(1, 2, BUF) * 0.05
    with torch.inference_mode():
        first = wrap.forward(x)
        second = wrap.forward(x)
    # cache evolves (warmup -> steady), so identical input gives different output
    assert not torch.allclose(first, second)
