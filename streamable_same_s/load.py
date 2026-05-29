"""Load original SAME-S weights into the scriptable `SAMESCore`.

Rather than parsing safetensors keys, we instantiate the original `AudioAutoencoder`
(via `loading_utils.load_autoencoder`) and copy its *effective* weights module-by-module
into the clean module. Weight-normed convs expose their fused `.weight`, so a dummy
forward is run first to make sure it is populated.
"""

from __future__ import annotations

import torch

from stable_audio_3.loading_utils import load_autoencoder
from stable_audio_3.model_configs import ae_models
from .same_s_ts import (
    ALIGN,
    DyT,
    SAMESCore,
    TransformerBlock,
)


def _copy_dyt(dst: DyT, src) -> None:
    dst.alpha.data.copy_(src.alpha.data)
    dst.gamma.data.copy_(src.gamma.data)
    dst.beta.data.copy_(src.beta.data)


def _copy_block(dst: TransformerBlock, src) -> None:
    _copy_dyt(dst.pre_norm, src.pre_norm)
    dst.attn.to_qkv.weight.data.copy_(src.self_attn.to_qkv.weight.data)
    dst.attn.to_out.weight.data.copy_(src.self_attn.to_out.weight.data)
    _copy_dyt(dst.attn.q_norm, src.self_attn.q_norm)
    _copy_dyt(dst.attn.k_norm, src.self_attn.k_norm)
    _copy_dyt(dst.ff_norm, src.ff_norm)
    dst.ff.glu_proj.weight.data.copy_(src.ff.ff[0].proj.weight.data)
    dst.ff.glu_proj.bias.data.copy_(src.ff.ff[0].proj.bias.data)
    dst.ff.proj_out.weight.data.copy_(src.ff.ff[2].weight.data)
    dst.ff.proj_out.bias.data.copy_(src.ff.ff[2].bias.data)


def copy_weights(ae, core: SAMESCore) -> SAMESCore:
    """Copy weights from a loaded `AudioAutoencoder` into a fresh `SAMESCore`."""
    # Populate weight_norm `.weight` attributes with a dummy aligned forward.
    spl = int(ae.downsampling_ratio)
    with torch.inference_mode():
        dummy = torch.zeros(1, ae.io_channels, spl * ALIGN, device=next(ae.parameters()).device)
        ae.decode(ae.encode(dummy))

    enc_trb = ae.encoder.layers[0]
    core.enc_mapping.weight.data.copy_(enc_trb.mapping.weight.data.squeeze(-1))
    core.enc_mapping.bias.data.copy_(enc_trb.mapping.bias.data)
    core.enc_new_tokens.data.copy_(enc_trb.new_tokens.data)
    for i in range(3):
        _copy_block(core.enc_transformer.blocks_first[i], enc_trb.transformers[i])
        _copy_block(core.enc_transformer.blocks_second[i], enc_trb.transformers[3 + i])
    core.enc_project_out.weight.data.copy_(ae.encoder.layers[2].weight.data)
    core.enc_project_out.bias.data.copy_(ae.encoder.layers[2].bias.data)

    core.dec_project_in.weight.data.copy_(ae.decoder.layers[1].weight.data)
    core.dec_project_in.bias.data.copy_(ae.decoder.layers[1].bias.data)
    dec_trb = ae.decoder.layers[3]
    core.dec_new_tokens.data.copy_(dec_trb.new_tokens.data)
    for i in range(3):
        _copy_block(core.dec_transformer.blocks_first[i], dec_trb.transformers[i])
        _copy_block(core.dec_transformer.blocks_second[i], dec_trb.transformers[3 + i])
    core.dec_mapping.weight.data.copy_(dec_trb.mapping.weight.data)
    core.dec_mapping.bias.data.copy_(dec_trb.mapping.bias.data)

    core.scaling_factor.data.copy_(ae.bottleneck.scaling_factor.data)
    core.sn_bias.data.copy_(ae.bottleneck.bias.data)
    core.running_std.data.copy_(ae.bottleneck.running_std.data)
    return core


def load_same_s_ts(device: str = "cpu", model: str = "same-s"):
    """Return (core, ae): the scriptable SAMESCore and the original AudioAutoencoder.

    The original `ae` is returned so callers can validate numeric parity.
    """
    config_path, ckpt_path = ae_models[model].resolve()
    ae = load_autoencoder(config_path, ckpt_path, device=device)
    ae.eval().requires_grad_(False)
    core = SAMESCore().to(device).eval()
    copy_weights(ae, core)
    core.requires_grad_(False)
    return core, ae
