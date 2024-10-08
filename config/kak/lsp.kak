eval %sh{ kak-lsp --kakoune -s "$kak_session" }

# These are not supported on older version of kakoune
try %{ lsp-inlay-diagnostics-enable global }
try %{ lsp-auto-hover-enable }

set-option global lsp_auto_highlight_references true
set-option global lsp_auto_show_code_actions true
set-option global lsp_hover_anchor true

hook global WinSetOption filetype=(python|zig) %{
    lsp-enable-window
}
