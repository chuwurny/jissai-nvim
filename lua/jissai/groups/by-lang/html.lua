---@param hls jissai.highlights
---@param gr jissai.groups
return function(hls, gr)
    gr.htmlTag = hls.text
    gr.htmlTagName = hls.text

    gr.htmlArg = hls.text
    gr.htmlEndTag = hls.text
    gr.htmlSpecialTagName = hls.text

    gr.htmlH1 = hls.text
    gr.htmlH2 = hls.text
    gr.htmlH3 = hls.text
    gr.htmlH4 = hls.text
    gr.htmlH5 = hls.text
    gr.htmlH6 = hls.text

    gr.htmlTitle = hls.text
    gr.htmlValue = hls.builtin.value
end
