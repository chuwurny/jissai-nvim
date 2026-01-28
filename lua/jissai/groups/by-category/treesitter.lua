---@param hls jissai.highlights
---@param gr jissai.groups
return function(hls, gr)
    gr["@number"] = { link = "Number" }

    gr["@keyword"] = hls.syntax.keyword
    gr["@keyword.function"] = hls.function_.keyword
    gr["@keyword.operator"] = hls.operator.keyword
    gr["@keyword.return"] = hls.operator.return_

    gr["@function"] = hls.function_.call
    gr["@function.method"] = hls.function_.define
    gr["@function.method.call"] = hls.function_.call
    gr["@function.call"] = hls.function_.call
    gr["@function.builtin"] = "undefine"

    gr["@variable.parameter"] = hls.variable.define

    gr["@constructor"] = hls.text

    gr["@string.regexp"] = hls.string.regex
    gr["@string.escape"] = hls.string.escape
    gr["@character.printf"] = hls.string.regex

    gr["@constant.builtin"] = hls.builtin.keyword

    gr["@label"] = hls.variable.use
end
