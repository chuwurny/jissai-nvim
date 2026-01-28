---@param p string
---@return any
---@return boolean match
local function path(tbl, p)
    local res = tbl

    for match in string.gmatch(p, "([%w_]+)") do
        if res == nil then
            return nil, false
        end

        res = res[match]
    end

    return res, true
end

---@return string
local function pluginPath()
    local src = debug.getinfo(1, "S").source

    local pathToThisFile = string.match(src, "^@([%w%-%.%_%/]+/jissai)/lib/utils%.lua$")

    assert(pathToThisFile, "impossible")

    return pathToThisFile
end

---@param dst table
---@param src table
local function merge(dst, src)
    dst = vim.deepcopy(dst)

    for k, v in pairs(src) do
        if dst[k] == nil then
            dst[k] = v
        end
    end

    return dst
end

---@param input any
---@return boolean
local function isHsl(input)
    return type(input) == "table"
        and type(input.h) == "number"
        and type(input.s) == "number"
        and type(input.l) == "number"
end

---@param input any
---@return boolean
local function isRgb(input)
    return type(input) == "table"
        and type(input.r) == "number"
        and type(input.g) == "number"
        and type(input.b) == "number"
end

---@return boolean using
---@return string? flavor
local function isNeovimUsingThisColorscheme()
    if not vim.g.colors_name then
        return false, nil
    end

    local flavor = string.match(vim.g.colors_name, "^jissai%-([%w_%-]+)$")

    if not flavor then
        return false, nil
    end

    return true, flavor
end

return {
    path = path,
    pluginPath = pluginPath,
    isHsl = isHsl,
    isRgb = isRgb,
    merge = merge,
    isNeovimUsingThisColorscheme = isNeovimUsingThisColorscheme,
}
