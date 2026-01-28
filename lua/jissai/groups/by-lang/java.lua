---@param hls jissai.highlights
---@param gr jissai.groups
return function(hls, gr)
    gr.javaParen = hls.syntax.decoration
    gr.javaParenT = hls.syntax.decoration
    gr.javaParenT1 = hls.syntax.decoration
    gr.javaParen1 = hls.syntax.decoration

    gr.javaBlock = hls.syntax.decoration
    gr.javaBlockOther = hls.syntax.decoration

    -- public private
    gr.javaScopeDecl = hls.syntax.keyword
    gr.javaOperator = hls.operator.regular

    gr.javaConstant = hls.builtin.keyword

    -- break
    gr.javaBranch = hls.operator.break_
    -- return
    gr.javaStatement = hls.operator.return_
    -- try catch
    gr.javaExceptions = hls.operator.throw

    gr["@lsp.type.method.java"] = hls.function_.call
end
