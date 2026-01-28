---@param hls jissai.highlights
---@param gr jissai.groups
return function(hls, gr)
    gr.Comment = hls.comment.regular
    gr.Todo = hls.comment.todo
    gr["@text.note"] = hls.comment.note

    gr.Statement = hls.syntax.keyword
    gr.Operator = hls.operator.regular
    gr.Boolean = hls.builtin.keyword
    gr.Type = hls.text
    gr.Identifier = hls.text
    gr.Delimiter = hls.syntax.decoration
    gr.Special = hls.builtin.value
    gr.String = hls.string.regular
    gr.Function = hls.function_.keyword
    gr.Macro = hls.macro
    gr.PreProc = hls.syntax.decoration
    gr.Number = hls.number
end
