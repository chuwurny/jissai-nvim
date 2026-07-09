---@param hls jissai.highlights
---@param gr jissai.groups
return function(hls, gr)
    gr.FlashBackdrop = hls.gui.notext
    gr.FlashMatch = hls.macro
    gr.FlashCurrent = { link = "FlashMatch" }
    gr.FlashLabel = hls.gui.search_result
end
