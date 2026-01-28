---@diagnostic disable-next-line: unused
---@param hls jissai.highlights
---@param gr jissai.groups
return function(hls, gr)
    gr.NeogitDiffAdd = { link = "GitAdd" }
    gr.NeogitDiffAddHighlight = { link = "NeogitDiffAdd" }

    gr.NeogitDiffDelete = { link = "GitDelete" }
    gr.NeogitDiffDeleteHighlight = { link = "NeogitDiffDelete" }
end
