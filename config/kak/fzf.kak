# fzf
define-command open -params 1 %{
    tmux-terminal-window sh -c %sh{
        printf '%s | sed -E' "$1"
        printf " -e \"s/'/''''/g\" "
        printf " -e \"s/^/evaluate-commands -client '%s' 'edit ''/\" " "$kak_client"
        printf " -e \"s/\$/'''/\" "
        printf " -e \"s/:([0-9]+).*/'''\\\\nexecute-keys -client '%s' \\\\1g/\" |" "$kak_client"
        printf " kak -p '%s'" "$kak_session"
    }
}

define-command fzf-fb      %{ open fzf-fb }
define-command fzf-fd      %{ open fzf-fd }
define-command fzf-fd-tree %{ open fzf-fd-tree }
define-command fzf-rg      %{ open fzf-rg }

map global user b ':fzf-fb<ret>'      -docstring 'Fzf file browser'
map global user t ':fzf-fd-tree<ret>' -docstring 'Fzf files tree'
map global user f ':fzf-fd<ret>'      -docstring 'Fzf files'
map global user s ':fzf-rg<ret>'      -docstring 'Fzf content of files'
