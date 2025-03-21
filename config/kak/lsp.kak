eval %sh{ kak-lsp --kakoune -s "$kak_session" }

set-option global lsp_auto_highlight_references true
set-option global lsp_auto_show_code_actions true

hook global WinSetOption filetype=zig %{
    lsp-enable-window

    # These are not supported on older version of kakoune
    try %{ lsp-inlay-diagnostics-enable global }
}

map global user r ':lsp-rename-prompt<ret>' -docstring 'Rename symbol'
map global user a ':lsp-code-actions<ret>'  -docstring 'Perform code actions'
