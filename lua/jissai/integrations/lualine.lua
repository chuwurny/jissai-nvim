local compileHighlight = require("jissai.lib.compiler").compileHighlight
local merge = require("jissai.lib.utils").merge

---@param palette jissai.palette
---@param hls jissai.highlights
local function generate(palette, hls)
    local function compile(tbl)
        for _, sections in pairs(tbl) do
            for sectionName, hl in pairs(sections) do
                sections[sectionName] = compileHighlight(hls, hl)
            end
        end

        return tbl
    end

    local default = {
        a = {
            as = "gui.status_line.focus",
            bg = palette.overlay0,
            fg = palette.text,
        },
        b = {
            as = "gui.status_line.focus",
            bg = palette.surface2,
            fg = palette.subtext0,
        },
        c = { as = "gui.status_line.focus" },
    }

    default.z = default.a

    local function override(tbl)
        return merge(tbl, default)
    end

    return compile({
        normal = default,
        insert = override({ a = { fg = palette.base0, bg = palette.sky } }),
        visual = override({ a = { bg = hls.gui.selection.fg } }),
        replace = override({ a = { fg = palette.text, bg = palette.red } }),
        command = override({ a = { bg = palette.surface2 } }),
        inactive = { a = hls.gui.status_line.nofocus },
    })
end

---@param palette jissai.palette
---@param hls jissai.highlights
local function applyEx(palette, hls)
    pcall(function()
        require("lualine").setup({
            options = { theme = generate(palette, hls) },
        })
    end)
end

---@param flavor jissai.flavor
local function apply(flavor)
    local palette = require("jissai.palette").flavor(flavor)
    local hls = require("jissai.highlights").highlightsFromPalette(palette)

    applyEx(palette, hls)
end

return { apply = apply, applyEx = applyEx } --[[@as jissai.integration]]
