---@param hls jissai.highlights
---@param gr jissai.groups
return function(hls, gr)
    -- *prop*:
    -- someName:
    gr.qmlBindingProperty = hls.text

    -- { } [ ]
    gr.qmlBraces = hls.syntax.decoration

    -- ( )
    gr.qmlParens = hls.syntax.decoration

    -- status
    gr.qmlMessage = hls.text

    -- required
    -- variable
    gr.qmlDeclaration = hls.syntax.keyword
end
