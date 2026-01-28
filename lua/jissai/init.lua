local paletteLib = require("jissai.palette")
local highlightsLib = require("jissai.highlights")
local group = require("jissai.groups").group
local compile = require("jissai.lib.compiler").compile
local pluginPath = require("jissai.lib.utils").pluginPath
local config = require("jissai.config")

local function clearHighlights()
    vim.api.nvim_exec(
        table.concat({
            "highlight clear",
            "set t_Co=256",
        }, "\n"),
        false
    )
end

---@class jissai.integration
---@field apply fun(flavor: jissai.flavor)
---@field applyEx fun(palette: jissai.palette, highligts: jissai.highlights)

---@return fun(): jissai.integration
local function iterIntegrations()
    local iter = vim.fs.dir(pluginPath() .. "/integrations/")

    return function()
        while true do
            local filename, filetype = iter()

            if filename == nil then
                return nil
            end

            if filetype == "file" then
                local filenameNoExt = string.match(filename, "^(.+)%.lua$")

                local integration = require("jissai.integrations." .. filenameNoExt)

                if type(integration.apply) ~= "function" then
                    error("Integration module " .. filenameNoExt .. " doesn't have exposed apply function!")
                end

                return integration
            end
        end
    end
end

---@param palette jissai.palette
---@param hls jissai.highlights
local function applyIntegrationsEx(palette, hls)
    for integration in iterIntegrations() do
        integration.applyEx(palette, hls)
    end
end

---@param flavor jissai.flavor
local function applyIntegrations(flavor)
    for integration in iterIntegrations() do
        integration.apply(flavor)
    end
end

---@param highlights jissai.highlights
---@param groups jissai.groups
local function applyGroup(highlights, groups)
    clearHighlights()

    local hls = compile(highlights, groups)

    vim.api.nvim_set_hl(0, "Normal", hls.Normal)

    for name, hl in pairs(hls) do
        if name ~= "Normal" then
            vim.api.nvim_set_hl(0, name, hl)
        end
    end
end

---@param palette jissai.palette
local function applyPalette(palette)
    local highlights = highlightsLib.highlightsFromPalette(palette)

    applyGroup(highlights, group(highlights))
end

---@param highlights jissai.highlights
local function applyHighlights(highlights)
    applyGroup(highlights, group(highlights))
end

---@param flavor jissai.flavor
---@param doApplyIntegrations? boolean # Default: true
local function apply(flavor, doApplyIntegrations)
    local palette = paletteLib.flavor(flavor)
    local highlights = highlightsLib.highlightsFromPalette(palette)

    applyGroup(highlights, group(highlights))

    if doApplyIntegrations ~= false then
        applyIntegrations(flavor)
    end
end

---@param bg "dark"|"light"
---@param flavor jissai.flavor
local function setNeovimColorscheme(bg, flavor)
    vim.opt.background = bg

    -- unload all jissai modules
    for pkgName in pairs(package.loaded) do
        if string.match(pkgName, "^jissai") then
            package.loaded[pkgName] = nil
        end
    end

    require("jissai").apply(flavor)

    vim.g.colors_name = "jissai-" .. flavor
end

return {
    setup = config.setup,

    apply = apply,
    applyGroup = applyGroup,
    applyHighlights = applyHighlights,
    applyPalette = applyPalette,
    applyIntegrations = applyIntegrations,
    applyIntegrationsEx = applyIntegrationsEx,

    setNeovimColorscheme = setNeovimColorscheme,
}
