local hsluv = require("jissai.lib.hsluv")
local isHsl = require("jissai.lib.utils").isHsl

---@class jissai.rgb
---@field r number # [0; 255]
---@field g number # [0; 255]
---@field b number # [0; 255]
local RGB = {}
RGB.__index = RGB

--- Returns copy of this color
---@return jissai.rgb
function RGB:clone()
    return setmetatable({ r = self.r, g = self.g, b = self.b }, RGB)
end

---@protected
---@param field "r"|"g"|"b"
---@param amount number
---@return jissai.rgb
function RGB:modify(field, amount)
    if amount >= 0 and amount < 1 then
        self[field] = self[field] * amount
    else
        self[field] = math.max(0, math.min(255, self[field] + amount))
    end

    return self
end

--- Adds red and returns new color
---@param amount number
---@return jissai.rgb
function RGB:re(amount)
    return self:clone():modify("r", amount)
end

--- Adds green and returns new color
---@param amount number
---@return jissai.rgb
function RGB:gr(amount)
    return self:clone():modify("g", amount)
end

--- Adds blue and returns new color
---@param amount number
---@return jissai.rgb
function RGB:bl(amount)
    return self:clone():modify("b", amount)
end

--- Changes r/g/b parts for this color
--- NOTE: doesn't return new color
---@param r? number
---@param g? number
---@param b? number
---@return jissai.rgb
function RGB:set(r, g, b)
    if r then
        self.r = r
    end

    if g then
        self.g = g
    end

    if b then
        self.b = b
    end

    return self
end

--- Converts to HSL and returns new color
---@return jissai.hsl
function RGB:hsl()
    return require("jissai.lib.types.hsl").hsl(hsluv.rgb_to_hsluv({ self.r, self.g, self.b }))
end

--- Converts to HEX string
---@return string
function RGB:hex()
    return hsluv.rgb_to_hex({ self.r, self.g, self.b })
end

--- Mixes color with background to imitate alpha change
---@param bg jissai.hsl|jissai.rgb
---@param weight number # [0; 1]
---@return jissai.rgb
function RGB:alpha(bg, weight)
    if isHsl(bg) then
        bg = bg:rgb()
    end

    return self:clone():set(
        self.r * weight + bg.r * (1 - weight),
        self.g * weight + bg.g * (1 - weight),
        self.b * weight + bg.b * (1 - weight)
    )
end

---@param input string|jissai.hsl|{ [1]: number, [2]: number, [3]: number }
---@return jissai.rgb
local function rgb(input)
    if type(input) == "string" then
        return rgb(hsluv.hex_to_rgb(input))
    elseif type(input) == "table" then
        if isHsl(input) then
            ---@cast input jissai.hsl

            return input:rgb()
        end

        return setmetatable({ r = input[1], g = input[2], b = input[3] }, RGB)
    else
        error("Invalid type is passed: " .. type(input))
    end
end

return { rgb = rgb, RGB = RGB }
