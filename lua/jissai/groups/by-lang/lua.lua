---@param hls jissai.highlights
---@param gr jissai.groups
return function(hls, gr)
    gr["@lsp.type.property.lua"] = "undefine"
    gr["@lsp.type.operator.lua"] = "undefine"
    gr["@lsp.type.string.lua"] = "undefine"

    gr["@function.lua"] = hls.function_.define

    gr["@constructor.lua"] = "undefine"
end
