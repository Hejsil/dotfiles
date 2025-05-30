hook global WinSetOption filetype=git-commit %{ set-option window formatcmd 'dprint --config ~/.config/dprint/git-commit.json fmt --stdin md' }
hook global WinSetOption filetype=css        %{ set-option window formatcmd 'dprint --config ~/.config/dprint/config.json fmt --stdin css' }
hook global WinSetOption filetype=html       %{ set-option window formatcmd 'dprint --config ~/.config/dprint/config.json fmt --stdin html' }
hook global WinSetOption filetype=html       %{ set-option window formatcmd 'dprint --config ~/.config/dprint/config.json fmt --stdin html' }
hook global WinSetOption filetype=javascript %{ set-option window formatcmd 'dprint --config ~/.config/dprint/config.json fmt --stdin js' }
hook global WinSetOption filetype=json       %{ set-option window formatcmd 'dprint --config ~/.config/dprint/config.json fmt --stdin json' }
hook global WinSetOption filetype=markdown   %{ set-option window formatcmd 'dprint --config ~/.config/dprint/config.json fmt --stdin md' }
hook global WinSetOption filetype=python     %{ set-option window formatcmd 'dprint --config ~/.config/dprint/config.json fmt --stdin py' }
hook global WinSetOption filetype=toml       %{ set-option window formatcmd 'dprint --config ~/.config/dprint/config.json fmt --stdin toml' }
hook global WinSetOption filetype=typescript %{ set-option window formatcmd 'dprint --config ~/.config/dprint/config.json fmt --stdin ts' }
hook global WinSetOption filetype=yaml       %{ set-option window formatcmd 'dprint --config ~/.config/dprint/config.json fmt --stdin yml' }

hook global WinSetOption filetype=c          %{ set-option window formatcmd 'clang-format' }
hook global WinSetOption filetype=java       %{ set-option window formatcmd 'astyle --max-code-length=100 --mode=java' }
hook global WinSetOption filetype=lua        %{ set-option window formatcmd "stylua - --indent-width %opt{tabstop} --indent-type Spaces --column-width 100 --quote-style AutoPreferDouble --call-parentheses Always" }
hook global WinSetOption filetype=nix        %{ set-option window formatcmd 'nixpkgs-fmt' }
hook global WinSetOption filetype=rust       %{ set-option window formatcmd 'rustfmt --edition 2018' }
hook global WinSetOption filetype=sh         %{ set-option window formatcmd "shfmt -i %opt{tabstop} -s -ci" }
hook global WinSetOption filetype=xml        %{ set-option window formatcmd 'xmllint --format -' }

hook global WinSetOption filetype=ini        %{ set-option window formatcmd 'cat' }
hook global WinSetOption filetype=kak        %{ set-option window formatcmd 'cat' }

hook global BufWritePre .* %{
    try format catch %{
        try lsp-formatting-sync catch %{}
    }
}
