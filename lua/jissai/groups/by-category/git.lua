---@param hls jissai.highlights
---@param gr jissai.groups
return function(hls, gr)
    gr.GitAdd = hls.gui.git.add
    gr.GitChange = hls.gui.git.change
    gr.GitDelete = hls.gui.git.delete

    gr.gitcommitSummary = hls.string.regular
    gr.gitcommitOverflow = hls.diagnostic.warn
end
