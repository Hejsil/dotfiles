eval %sh{kak-lsp --kakoune -s "$kak_session"}
lsp-enable

# lsp-inlay-diagnostics-enable global
# lsp-auto-hover-enable

set-option global lsp_auto_highlight_references true
set-option global lsp_auto_show_code_actions true
set-option global lsp_hover_anchor true
