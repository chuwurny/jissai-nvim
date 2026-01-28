---@generic T
---@param tbl { [string]: T }
---@return { [string]: T }
local function toAnyScript(tbl)
    local res = {}

    for k, v in pairs(tbl) do
        local whatScript, type = string.match(k, "^(%w%w%w%w)[Ss]cript(.*)$")

        type = type or ""

        if whatScript == "type" then
            res["javaScript" .. type] = v
        elseif whatScript == "java" then
            res["typescript" .. type] = v
        end

        res[k] = v
    end

    return res
end

---@param hls jissai.highlights
---@param gr jissai.groups
return function(hls, gr)
    local groupsToApply = toAnyScript({
        javaScript = hls.text, -- TODO: it's used in "vue", should we move it?

        typescriptCall = "undefine",

        typescriptObjectLabel = hls.text,
        typescriptMember = hls.text,

        typescriptImport = hls.syntax.keyword,
        typescriptImportType = hls.syntax.keyword,
        typescriptExport = hls.syntax.keyword,

        typescriptOperator = hls.operator.keyword,
        typescriptStatementKeyword = hls.operator.return_, -- return
        typescriptAssign = hls.operator.regular, -- =
        typescriptBraces = hls.syntax.decoration, -- { }
        typescriptParens = hls.syntax.decoration, -- ( )
        typescriptArrowFunc = hls.syntax.decoration, -- =>
        typescriptVariable = hls.syntax.keyword, -- const var let
        typescriptTypeAnnotation = hls.syntax.decoration, -- : <type>
        typescriptArray = hls.syntax.decoration, -- ,
        typescriptObjectLiteral = hls.syntax.decoration, -- ,
        typescriptEndColons = hls.syntax.decoration, -- ;   (in loop)
        typescriptObjectColon = hls.syntax.decoration, -- <field>:
        typescriptTemplateSB = hls.syntax.decoration, -- ${ }
        typescriptTypeBracket = hls.syntax.decoration, -- [ ]
        typescriptObjectType = hls.syntax.decoration, -- =>
        typescriptCastKeyword = hls.syntax.keyword, -- as
        typescriptTry = hls.syntax.keyword, -- try
        typescriptExceptions = hls.syntax.keyword, -- catch throw

        typescriptFuncCallArg = hls.text,
        typescriptFuncType = hls.text,
        typescriptFuncTypeArrow = hls.text,

        typescriptInterfaceName = "undefine",

        typescriptSpecial = hls.string.escape,
    })

    for k, v in pairs(groupsToApply) do
        gr[k] = v
    end
end
