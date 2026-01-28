---@param hls jissai.highlights
---@param gr jissai.groups
return function(hls, gr)
    gr.LspCodeLens = hls.lsp.code_lens
    gr.LspInlayHint = hls.lsp.inlay_hint

    gr["@lsp.type.parameter"] = hls.variable.use

    gr["@lsp.type.property"] = "undefine"

    gr["@lsp.type.macro"] = { link = "Macro" }

    gr["@lsp.typemod.keyword.async"] = hls.operator.flow

    gr["@lsp.mod.declaration"] = hls.variable.define
end
