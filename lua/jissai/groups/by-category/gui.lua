---@param hls jissai.highlights
---@param gr jissai.groups
return function(hls, gr)
    gr.Normal = hls.gui.background.focus
    gr.NormalNC = hls.gui.background.nofocus

    gr.NormalFloat = { link = "Normal" }
    gr.FloatBorder = hls.gui.border

    gr.NonText = hls.gui.notext

    gr.CursorLine = hls.gui.cursor_line
    gr.CursorColumn = { link = "CursorLine" }

    gr.Search = hls.gui.search
    gr.CurSearch = { link = "Search" }
    gr.IncSearch = hls.gui.search_result

    gr.EndOfBuffer = hls.gui.notext

    gr.ColorColumn = { link = "CursorLine" }

    gr.StatusLine = hls.gui.status_line.focus
    gr.StatusLineNC = hls.gui.status_line.nofocus

    gr.Visual = hls.gui.selection

    gr.Cursor = hls.gui.cursor

    gr.DiagnosticOk = hls.diagnostic.ok
    gr.DiagnosticHint = hls.diagnostic.hint
    gr.DiagnosticInfo = hls.diagnostic.info
    gr.DiagnosticWarn = hls.diagnostic.warn
    gr.DiagnosticError = hls.diagnostic.error

    gr.Pmenu = hls.gui.float_background
    gr.PmenuSel = hls.gui.selection

    gr.PmenuSbar = hls.gui.scrollbar.background
    gr.PmenuThumb = hls.gui.scrollbar.grip

    gr.WinSeparator = hls.gui.border

    gr.WinBar = hls.gui.float_background
    gr.WinBarNC = { link = "WinBar" }
end
