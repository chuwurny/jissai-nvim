local isHsl = require("jissai.lib.utils").isHsl

local paletteLib = require("jissai.palette")
local config = require("jissai.config")

---@param input jissai.highlight
---@return string? badField
local function validateHighlight(input)
    if input.fg ~= nil and (not isHsl(input.fg) and input.fg ~= "NONE") then
        return "fg"
    end

    if input.bg ~= nil and (not isHsl(input.bg) and input.bg ~= "NONE") then
        return "bg"
    end

    if input.style ~= nil then
        for _, style in ipairs(input.style) do
            if
                not vim.tbl_contains({
                    "bold",
                    "standout",
                    "underline",
                    "undercurl",
                    "underdouble",
                    "underdotted",
                    "underdashed",
                    "strikethrough",
                    "italic",
                    "reverse",
                }, style)
            then
                return "style"
            end
        end
    end

    if input.blend ~= nil and (type(input.blend) ~= "number" or input.blend < 0 or input.blend > 100) then
        return "blend"
    end

    if input.combine ~= nil and type(input.combine) ~= "boolean" then
        return "combine"
    end

    if input.link ~= nil and type(input.link) ~= "string" then
        return "link"
    end

    if input.as ~= nil and type(input.as) ~= "string" then
        return "as"
    end

    for k in pairs(input) do
        if not vim.tbl_contains({ "fg", "bg", "style", "blend", "combine", "link", "as" }, k) then
            return "unknown_field:" .. tostring(k)
        end
    end
end

---@param palette jissai.palette
---@return jissai.highlights
local function highlightsFromPalette(palette)
    local hls = {
        gui = {
            background = {
                focus = {
                    fg = palette.text,
                    bg = palette.base0,
                    combine = true,
                },
                nofocus = { as = "gui.background.focus" },
            },
            float_background = {
                as = "gui.background.focus",
                bg = palette.surface0,
            },
            border = { fg = palette.surface1, combine = true },
            float_border = {
                as = "gui.float_background",
                fg = palette.surface1,
                combine = true,
            },
            shadow = { bg = palette.overlay2, combine = true },
            notext = { fg = palette.subtext0, combine = true },
            cursor = { style = { "reverse" }, combine = true }, --{ fg = palette.text, bg = palette.crust, combine = true },
            cursor_line = { bg = palette.base1, combine = true },
            search = {
                bg = palette.yellow:rgb():alpha(palette.base0, 0.5):hsl(),
                combine = true,
            },
            search_result = {
                bg = palette.orange:rgb():alpha(palette.base0, 0.5):hsl(),
                combine = true,
            },
            selection = { bg = palette.base2, combine = true },
            status_line = {
                focus = { fg = palette.subtext1, bg = palette.surface1 },
                nofocus = { fg = palette.subtext1, bg = palette.surface0 },
            },
            scrollbar = {
                background = { bg = palette.surface1, combine = true },
                grip = { bg = palette.surface2, combine = true },
            },
            git = {
                add = {
                    fg = palette.green,
                    bg = palette.green:rgb():alpha(palette.base0, 0.3):hsl(),
                },
                change = {
                    fg = palette.yellow,
                    bg = palette.yellow:rgb():alpha(palette.base0, 0.3):hsl(),
                },
                delete = {
                    fg = palette.red,
                    bg = palette.red:rgb():alpha(palette.base0, 0.3):hsl(),
                },
            },
        },
        text = { fg = palette.text },
        number = { fg = palette.yellow },
        macro = { fg = palette.pink },
        comment = {
            regular = {
                fg = palette.text,
                bg = palette.teal:rgb():alpha(palette.base0, 0.35):hsl(),
            },
            todo = { fg = palette.base0, bg = palette.purple },
            note = {
                fg = palette.text,
                bg = palette.sky:rgb():alpha(palette.base0, 0.2):hsl(),
            },
        },
        string = {
            regular = {
                fg = palette.green,
                bg = palette.green:rgb():alpha(palette.base0, 0.2):hsl(),
            },
            escape = { fg = palette.teal, as = "string.regular" },
            special = { fg = palette.orange, as = "string.regular" },
            regex = { fg = palette.yellow, as = "string.regular" },
        },
        operator = {
            regular = { fg = palette.text },
            flow = { fg = palette.red, combine = true },
            keyword = { as = "operator.regular", style = { "italic" } },
            return_ = { as = "operator.keyword", fg = palette.red },
            break_ = { as = "operator.return_" },
            continue_ = { as = "operator.return_" },
            throw = { as = "operator.return_" },
        },
        syntax = {
            decoration = { fg = palette.overlay0 },
            keyword = { as = "syntax.decoration", style = { "italic" } },
        },
        function_ = {
            keyword = { fg = palette.blue, style = { "italic" } },
            define = {
                as = "function_.keyword",
                bg = palette.blue:rgb():alpha(palette.base0, 0.2):hsl(),
                style = { "bold" },
            },
            call = { fg = palette.sky },
        },
        variable = {
            use = { style = { "bold" }, combine = true },
            define = { as = "variable.use", bg = palette.base1 },
        },
        builtin = {
            value = { fg = palette.orange, combine = true },
            keyword = {
                as = "builtin.value",
                combine = false,
                style = { "italic" },
            },
        },
        lsp = {
            inlay_hint = {
                fg = palette.purple:rgb():alpha(palette.base0, 0.5):hsl(),
                style = { "italic" },
            },
            code_lens = {
                as = "lsp.inlay_hint",
                bg = palette.base1,
            },
        },
        diagnostic = {
            ok = {
                fg = palette.text,
                bg = palette.green:rgb():alpha(palette.base0, 0.2):hsl(),
            },
            hint = {
                fg = palette.text,
                bg = palette.sky:rgb():alpha(palette.base0, 0.2):hsl(),
            },
            info = {
                fg = palette.text,
                bg = palette.blue:rgb():alpha(palette.base0, 0.2):hsl(),
            },
            warn = { fg = palette.base0, bg = palette.yellow },
            error = { fg = palette.base0, bg = palette.red },
        },
        docs = {
            types = {
                none = { fg = palette.overlay0 },
                namespace = { as = "text" },
                value = { as = "builtin.value" },
                class = { fg = palette.sky },
                interface = { fg = palette.sky },
                struct = { fg = palette.teal },
                enum = { fg = palette.orange },
                property = { fg = palette.text },
                variable = { as = "variable.use" },
                event = { fg = palette.yellow },
                macro = { as = "macro" },
                snippet = {
                    fg = palette.subtext1,
                    style = { "italic", "underline" },
                },
                function_ = { as = "function_.keyword" },
                keyword = { as = "string.regular" },
                path = { fg = palette.orange, style = { "italic" } },
                ai = { fg = palette.red },
            },
        },
        completion = {
            ai = {
                fg = palette.text,
                bg = palette.red:rgb():alpha(palette.base0, 0.5):hsl(),
                style = { "italic" },
            },
        },
    } --[[@as jissai.highlights]]

    if config.cfg.modifyHighlights then
        config.cfg.modifyHighlights(palette, hls)
    end

    return hls
end

---@param flavor jissai.flavor
---@return jissai.highlights
local function highlights(flavor)
    return highlightsFromPalette(paletteLib.flavor(flavor))
end

return {
    highlights = highlights,
    highlightsFromPalette = highlightsFromPalette,
    validateHighlight = validateHighlight,
}
