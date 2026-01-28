--@meta jissai.palette

local hsl = require("jissai.lib.types.hsl").hsl
local config = require("jissai.config")

--- Credits: https://catppuccin.com
---@return jissai.palette
local function latte()
    local palette = {
        blue = hsl("#1e66f5"),
        purple = hsl("#8839ef"), -- Mauve
        sky = hsl("#04a5e5"),
        teal = hsl("#179299"),
        green = hsl("#40a02b"),
        yellow = hsl("#df8e1d"),
        red = hsl("#d20f39"),
        orange = hsl("#fe640b"), -- Peach
        pink = hsl("#ea76cb"),

        text = hsl("#4c4f69"),
        subtext1 = hsl("#5c5f77"),
        subtext0 = hsl("#6c6f85"),

        overlay2 = hsl("#7c7f93"),
        overlay1 = hsl("#8c8fa1"),
        overlay0 = hsl("#9ca0b0"),

        surface2 = hsl("#acb0be"),
        surface1 = hsl("#bcc0cc"),
        surface0 = hsl("#ccd0da"),

        base0 = hsl("#eff1f5"),
        base1 = hsl("#e6e9ef"),
        base2 = hsl("#dce0e8"),
    } --[[@as jissai.palette]]

    return palette
end

--- Credits: https://catppuccin.com
---@return jissai.palette
local function mocha()
    local palette = {
        blue = hsl("#8aadf4"),
        purple = hsl("#c6a0f6"), -- Mauve
        sky = hsl("#91d7e3"),
        teal = hsl("#8bd5ca"),
        green = hsl("#a6da95"),
        yellow = hsl("#eed49f"),
        red = hsl("#ed8796"),
        orange = hsl("#f5a97f"), -- Peach
        pink = hsl("#f5bde6"),

        text = hsl("#cdd6f4"),
        subtext1 = hsl("#bac2de"),
        subtext0 = hsl("#a6adc8"),

        overlay2 = hsl("#9399b2"),
        overlay1 = hsl("#7f849c"),
        overlay0 = hsl("#6c7086"),

        surface2 = hsl("#585b70"),
        surface1 = hsl("#45475a"),
        surface0 = hsl("#313244"),

        base0 = hsl("#1e1e2e"),
        base1 = hsl("#181825"),
        base2 = hsl("#11111b"),
    } --[[@as jissai.palette]]

    return palette
end

---@return jissai.palette
local function light()
    local palette = {
        base0 = hsl("#ffffff"),
        base1 = hsl("#e0e0e1"),
        base2 = hsl("#cfced0"),

        text = hsl("#101010"),
        subtext0 = hsl("#202020"),
        subtext1 = hsl("#2e2e2e"),

        surface0 = hsl("#d1d1d1"),
        surface1 = hsl("#b7b7b7"),
        surface2 = hsl("#a4a4a4"),

        overlay0 = hsl("#949494"),
        overlay1 = hsl("#878787"),
        overlay2 = hsl("#7a7a7a"),

        -- https://paletton.com/#uid=53W0o0kn7Ud3dZzeRVdvAUrVEGF

        blue = hsl("#2337ef"),
        purple = hsl("#ab8df0"),
        sky = hsl("#4ea1ec"),

        -- https://paletton.com/#uid=1350U0klcv-eCMMidDGnVscqan5
        teal = hsl("#39aa7f"),
        -- https://paletton.com/#uid=12-0U0kwKwrjGDrp2yEyLoXDBjB
        green = hsl("#428c00"),
        -- https://paletton.com/#uid=11h0U0ku3mcmusnrZqtz8iDHNel
        yellow = hsl("#D3AB1B"),

        -- https://paletton.com/#uid=1000U0kiCFn8GVde7NVmtwSqXtg
        red = hsl("#e92525"),
        -- https://paletton.com/#uid=10n0U0koJtrfaFokkvWsZpdvnj+
        orange = hsl("#eb7b35"),
        -- https://paletton.com/#uid=1530U0kiCFn8GVde7NVmtwSqXtg
        pink = hsl("#c0399b"),
    } --[[@as jissai.palette]]

    return palette
end

---@return jissai.palette
local function dark()
    local palette = {
        base0 = hsl("#101010"),

        text = hsl("#ffffff"),

        --[[
        base1 = hsl("#202020"),
        base2 = hsl("#2e2e2e"),

        subtext0 = hsl("#e0e0e1"),
        subtext1 = hsl("#cfced0"),

        -- https://paletton.com/#uid=13W0o0k00gx009l00dk05j10pm7

        surface0 = hsl("#333333"),
        surface1 = hsl("#494949"),
        surface2 = hsl("#5b5b5b"),

        -- https://paletton.com/#uid=13W0o0k00p100iM00m302rz07uU

        overlay0 = hsl("#676767"),
        overlay1 = hsl("#797979"),
        overlay2 = hsl("#8a8a8a"),
        ]]

        subtext0 = hsl("#ffffff"):li(-8.5 * 1),
        subtext1 = hsl("#ffffff"):li(-8.5 * 2),

        base1 = hsl("#101010"):li(7.5 * 1),
        base2 = hsl("#101010"):li(7.5 * 2),

        surface0 = hsl("#101010"):li(7.5 * 3),
        surface1 = hsl("#101010"):li(7.5 * 4),
        surface2 = hsl("#101010"):li(7.5 * 5),
        overlay0 = hsl("#101010"):li(7.5 * 6),
        overlay1 = hsl("#101010"):li(7.5 * 7),
        overlay2 = hsl("#101010"):li(7.5 * 8),

        -- https://paletton.com/#uid=5410r0kl1Wx1x+IcEXDsUWkWEVB

        blue = hsl("#706bf4"),
        purple = hsl("#9e62f4"),
        sky = hsl("#60a5f3"),

        -- https://paletton.com/#uid=1390y0kiCFn8GVde7NVmtwSqXtg
        teal = hsl("#33a989"),
        -- https://paletton.com/#uid=12H0y0kleqtbzEKgVuIpcmGtdhZ
        green = hsl("#469b21"),
        -- https://paletton.com/#uid=11i0y0knkqNdWCdj8u6r0mzuOhP
        yellow = hsl("#d5b43a"),

        -- https://paletton.com/#uid=55C0n1kiCFn8GVde7NVmtwSqXtgkuitTi+zBnSuVvunRAYjlkiCFn8GVde7NVmtwSqXtg

        red = hsl("#e72529"),
        orange = hsl("#ee610d"),
        pink = hsl("#d74085"),
    } --[[@as jissai.palette]]

    return palette
end

---@alias jissai.flavor
---| "dark"
---| "light"
---| "latte"
---| "mocha"

---@param f jissai.flavor|string
---@return jissai.palette
local function flavor(f)
    if f == "dark" then
        return dark()
    elseif f == "light" then
        return light()
    elseif f == "latte" then
        return latte()
    elseif f == "mocha" then
        return mocha()
    else
        if config.cfg.applyCustomPalette then
            local palette = config.cfg.applyCustomPalette(f)

            if type(palette) == "table" then
                return palette
            end

            error(
                "Unknown flavor "
                    .. tostring(f)
                    .. " is passed. Though `applyCustomPalette` is set, it did not handle this flavor"
            )
        else
            error("Unknown flavor " .. tostring(f) .. " is passed")
        end
    end
end

return {
    dark = dark,
    light = light,
    latte = latte,
    mocha = mocha,
    flavor = flavor,
}
