---@diagnostic disable-next-line: unused
---@param hls jissai.highlights
---@param gr jissai.groups
return function(hls, gr)
    gr.GitGutterAdd = { link = "GitAdd" }
    gr.GitGutterChange = { link = "GitChange" }
    gr.GitGutterDelete = { link = "GitDelete" }
end
