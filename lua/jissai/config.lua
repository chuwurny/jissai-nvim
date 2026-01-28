local utils = require("jissai.lib.utils")

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
---
--- Default: `true`
---@field reapplyColorschemeOnSetup? boolean
local cfg = {}

---@param newCfg jissai.config
local function setup(newCfg)
    cfg = vim.tbl_extend("force", cfg, newCfg)

    if cfg.reapplyColorschemeOnSetup ~= false then
        local _, flavor = utils.isNeovimUsingThisColorscheme()

        if flavor then
            require("jissai").apply(flavor)
        end
    end
end

return { cfg = cfg, setup = setup }
