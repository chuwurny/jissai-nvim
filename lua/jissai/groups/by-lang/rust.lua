---@param hls jissai.highlights
---@param gr jissai.groups
return function(hls, gr)
    gr["@lsp.type.operator.rust"] = { link = "@lsp" }

    gr["@lsp.type.parameter.rust"] = hls.variable.use
    gr["@lsp.type.variable.rust"] = hls.variable.use
    --groups["@lsp.mod.declaration.rust"] = hls.variable.define

    gr["@lsp.type.method.rust"] = { link = "@lsp" }
    gr["@lsp.type.function.rust"] = { link = "@lsp" }

    gr.rustModPath = hls.text
    gr["@lsp.type.generic.rust"] = hls.text

    gr.rustStorage = hls.syntax.keyword
    gr.rustFoldBraces = hls.syntax.decoration
    gr.rustArrowCharacter = hls.syntax.decoration

    gr.rustSelf = hls.builtin.keyword

    gr.rustEscape = hls.string.escape

    gr.rustSigil = hls.operator.flow -- & *
    gr.rustQuestionMark = hls.operator.flow -- ?
    gr.rustOperator = hls.syntax.decoration

    gr.rustFuncName = hls.function_.define
    gr.rustFuncCall = hls.function_.call
end
