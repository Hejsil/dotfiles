eval %sh{ kak-lsp --kakoune -s "$kak_session" }
lsp-enable
lsp-inlay-diagnostics-enable global

set-option global lsp_auto_highlight_references true
set-option global lsp_auto_show_code_actions true

# Many of these are taken from:
# https://github.com/kakoune-lsp/kakoune-lsp/blob/master/rc/servers.kak
declare-option -hidden str lsp_server_c %{
    [clangd]
    args = [ "--log=error", "--clang-tidy", "--header-insertion=never" ]
    root_globs = [ "compile_commands.json", ".clangd", ".git", ".hg" ]
}
declare-option -hidden str lsp_server_html %{
    [superhtml]
    args = [ "lsp" ]
    root_globs = [ ".git", ".hg" ]
}
declare-option -hidden str lsp_server_python %{
    [pylsp]
    root_globs = [ "requirements.txt", "setup.py", "pyproject.toml", ".git", ".hg" ]
}
declare-option -hidden str lsp_server_typos %{
    [typos-lsp]
    root_globs = [ ".git", ".hg" ]
}
declare-option -hidden str lsp_server_zls %{
    [zls]
    root_globs = [ "build.zig" ]
}

declare-option -hidden str lsp_server_spellcheck %exp{
    %opt{lsp_server_typos}
}

remove-hooks global lsp-filetype-c-family
hook -group lsp-filetype-c-family global BufSetOption filetype=(?:c|cpp|objc) %{
    set-option buffer lsp_servers %exp{
        %opt{lsp_server_c}
        %opt{lsp_server_spellcheck}
    }
}

remove-hooks global lsp-filetype-markdown
hook -group lsp-filetype-markdown global BufSetOption filetype=markdown %{
    set-option buffer lsp_servers %exp{
        %opt{lsp_server_spellcheck}
    }
}
hook -group lsp-filetype-markdown global BufSetOption filetype=git-commit %{
    set-option buffer lsp_servers %exp{
        %opt{lsp_server_spellcheck}
    }
}

remove-hooks global lsp-filetype-html
hook -group lsp-filetype-html global BufSetOption filetype=html %{
    set-option buffer lsp_servers %exp{
        %opt{lsp_server_spellcheck}
        %opt{lsp_server_html}
    }
}

remove-hooks global lsp-filetype-python
hook -group lsp-filetype-python global BufSetOption filetype=python %{
    set-option buffer lsp_servers %exp{
        %opt{lsp_server_python}
        %opt{lsp_server_spellcheck}
    }
}

remove-hooks global lsp-filetype-zig
hook -group lsp-filetype-zig global BufSetOption filetype=zig %{
    set-option buffer lsp_servers %exp{
        %opt{lsp_server_spellcheck}
        %opt{lsp_server_zls}
    }
}

map global user r ':lsp-rename-prompt<ret>'        -docstring 'Rename symbol'
map global user a ':lsp-code-actions<ret>'         -docstring 'Perform code actions'

map global goto d '<esc>:lsp-definition<ret>'      -docstring 'LSP definition'
map global goto r '<esc>:lsp-references<ret>'      -docstring 'LSP references'
map global goto y '<esc>:lsp-type-definition<ret>' -docstring 'LSP type definition'
