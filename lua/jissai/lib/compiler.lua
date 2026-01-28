local validateHighlight = require("jissai.highlights").validateHighlight
local path = require("jissai.lib.utils").path
local merge = require("jissai.lib.utils").merge

---@alias jissai.neovim_highlights { [string]: jissai.neovim_highlight }

---@class jissai.neovim_highlight
---@field fg? string
---@field bg? string
---@field blend? number # [0; 100]
---@field bold? boolean
---@field standout? boolean
---@field underline? boolean
---@field undercurl? boolean
---@field underdouble? boolean
---@field underdotted? boolean
---@field underdashed? boolean
---@field strikethrough? boolean
---@field italic? boolean
---@field reverse? boolean
---@field nocombine? boolean
---@field link? string
---@field default? boolean
---@field ctermfg? string
---@field ctermbg? string
---@field cterm? jissai.neovim_highlight
---@field force? boolean

---@param color? jissai.hsl|"NONE"
---@return string?
local function parseColor(color)
    if color == nil then
        return nil
    end

    if color == "NONE" then
        return color
    end

    return color:hex()
end

---@param highlights jissai.highlights
---@param hl jissai.highlight
---@param nested? string[]
---@return jissai.highlight
local function resolveAs(highlights, hl, nested)
    if not hl.as then
        return hl
    end

    nested = nested or {}

    local resolvedHl, match = path(highlights, hl.as) --[[@as jissai.highlight?]]

    if not match then
        error("Failed to resolve " .. hl.as .. ": no match")
    elseif type(resolvedHl) ~= "table" then
        error("Failed to resolve " .. hl.as .. ": result is not a table but " .. type(resolvedHl))
    end

    local badField = validateHighlight(resolvedHl)

    if badField then
        error(
            "Failed to resolve "
                .. hl.as
                .. ': "as" field targets non-highlight/bad value (bad field: '
                .. badField
                .. ")"
                .. (#nested ~= 0 and ("\nNested: " .. table.concat(nested, " <- ")) or "")
                .. "\nResolved highlight: "
                .. vim.inspect(resolvedHl)
        )
    end

    if resolvedHl.as then
        resolvedHl = resolveAs(highlights, resolvedHl, { resolvedHl.as, unpack(nested) })
    end

    local newHl = merge(hl, resolvedHl) --[[@as jissai.highlight]]

    newHl.as = nil

    return newHl
end

---@param highlights jissai.highlights
---@param hl jissai.highlight|"undefine"
---@return jissai.neovim_highlight
local function compileHighlight(highlights, hl)
    if hl == "undefine" then
        return { nocombine = true }
    end

    if hl.link then
        return { link = hl.link }
    end

    hl = resolveAs(highlights, hl)

    local res = {
        fg = parseColor(hl.fg),
        bg = parseColor(hl.bg),
        nocombine = hl.combine ~= true,
        blend = hl.blend,
        link = hl.link,
    } --[[@as jissai.neovim_highlight]]

    if hl.style then
        for _, style in ipairs(hl.style) do
            ---@diagnostic disable-next-line: inject-field
            res[style] = true
        end
    end

    return res
end

---@param highlights jissai.highlights
---@param groups jissai.groups
---@return jissai.neovim_highlights
local function compile(highlights, groups)
    local ret = {}

    for group, hl in pairs(groups) do
        local ok, res = pcall(compileHighlight, highlights, hl)

        if ok then
            ret[group] = res
        else
            error('Failed to compile highlight "' .. group .. '": ' .. res)
        end
    end

    return ret
end

return { compileHighlight = compileHighlight, compile = compile }
