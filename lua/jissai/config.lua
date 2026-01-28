------------------------------------------------------------
---@class jissai.config
------------------------------------------------------------
--- Allows to change basic palette.
---
--- Return new palette to handle palette by custom name
---@field applyCustomPalette? fun(name: string): jissai.palette?
---
--- Allows to modify custom neovim highlights
---@field applyCustomGroups? jissai.groupModifier
---
--- Allows to modify default jissai highlights
---@field modifyHighlights? fun(palette: jissai.palette, hls: jissai.highlights)
local cfg = {}

---@param newCfg jissai.config
local function setup(newCfg)
    vim.tbl_extend("force", cfg, newCfg)
end

return { cfg = cfg, setup = setup }
