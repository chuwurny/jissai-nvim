local hsluv = require("jissai.lib.hsluv")
local isRgb = require("jissai.lib.utils").isRgb

---@class jissai.hsl
---@field h number # [0; 360]
---@field s number # [0; 100]
---@field l number # [0; 100]
local HSL = {}
HSL.__index = HSL

--- Returns copy of this color
---@return jissai.hsl
function HSL:clone()
    return setmetatable({ h = self.h, s = self.s, l = self.l }, HSL)
end

---@protected
---@param field "s"|"l"
---@param amount number
---@return jissai.hsl
function HSL:modify(field, amount)
    if amount >= 0 and amount < 1 then
        self[field] = self[field] * amount
    else
        self[field] = math.max(0, math.min(100, self[field] + amount))
    end

    return self
end

--- Adds hue and returns new color
---@param amount number
---@return jissai.hsl
function HSL:hu(amount)
    local new = self:clone()

    new.h = (new.h + amount) % 360

    return new
end

--- Adds saturation and returns new color
---@param amount number
---@return jissai.hsl
function HSL:sa(amount)
    return self:clone():modify("s", amount)
end

--- Adds lightness and returns new color
---@param amount number
---@return jissai.hsl
function HSL:li(amount)
    return self:clone():modify("l", amount)
end

--- Changes h/u/e parts for this color
--- NOTE: doesn't return new color
---@param h? number
---@param s? number
---@param l? number
---@return jissai.hsl
function HSL:set(h, s, l)
    if h then
        self.h = h
    end

    if s then
        self.s = s
    end

    if l then
        self.l = l
    end

    return self
end

--- Converts to RGB and returns new color
---@return jissai.rgb
function HSL:rgb()
    return require("jissai.lib.types.rgb").rgb(hsluv.hsluv_to_rgb({ self.h, self.s, self.l }))
end

--- Converts to HEX string
---@return string
function HSL:hex()
    return hsluv.hsluv_to_hex({ self.h, self.s, self.l })
end

---@param input string|jissai.rgb|{ [1]: number, [2]: number, [3]: number }
---@return jissai.hsl
local function hsl(input)
    if type(input) == "string" then
        return hsl(hsluv.hex_to_hsluv(input))
    elseif type(input) == "table" then
        if isRgb(input) then
            ---@cast input jissai.rgb

            return input:hsl()
        end

        return setmetatable({ h = input[1], s = input[2], l = input[3] }, HSL)
    else
        error("Invalid type is passed: " .. type(input))
    end
end

return { hsl = hsl, HSL = HSL }
