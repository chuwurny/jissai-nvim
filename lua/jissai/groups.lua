local pluginPath = require("jissai.lib.utils").pluginPath
local config = require("jissai.config")

local GROUP_SUB_DIRS = { "by-category", "by-lang", "by-plugins" }

---@return jissai.groupModifier[]
local function loadExtraGroupModifiers()
    local modifiers = {}

    local groupsPath = pluginPath() .. "/groups/"

    for _, subDir in ipairs(GROUP_SUB_DIRS) do
        local dir = groupsPath .. subDir

        for filename, filetype in vim.fs.dir(dir) do
            if filetype == "file" then
                local filenameNoExt = string.match(filename, "^(.+)%.lua$")

                local modifier = require("jissai.groups." .. subDir .. "." .. filenameNoExt)

                if type(modifier) ~= "function" then
                    error(
                        "Modifier module "
                            .. dir
                            .. "/"
                            .. filename
                            .. " returned non-function value! (got "
                            .. type(modifier)
                            .. ")"
                    )
                end

                table.insert(modifiers, modifier)
            end
        end
    end

    return modifiers
end

---@param hls jissai.highlights
---@return jissai.groups
local function group(hls)
    local groups = {} --[[@as jissai.groups]]

    for _, modify in ipairs(loadExtraGroupModifiers()) do
        modify(hls, groups)
    end

    if config.cfg.applyCustomGroups then
        config.cfg.applyCustomGroups(hls, groups)
    end

    return groups
end

return { group = group }
