---@param hls jissai.highlights
---@param gr jissai.groups
return function(hls, gr)
    gr.jsonKeyword = hls.text

    gr.jsonNoise = hls.syntax.decoration
    gr.jsonQuote = hls.syntax.decoration
    gr.jsonKeywordMatch = hls.syntax.decoration
end
