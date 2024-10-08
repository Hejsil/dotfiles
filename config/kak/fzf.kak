# fzf
define-command open -params 1 %{
    tmux-terminal-window sh -c %sh{
        printf '%s | sed -E -e "s/^/evaluate-commands -client %s edit / ;
            s/:([0-9]+).*/\\nexecute-keys -client %s \\1g/" | kak -p "%s"' \
            "$1" "$kak_client" "$kak_client" "$kak_session"
    }
}

define-command fzf-fd %{ open fzf-fd }
define-command fzf-ag %{ open fzf-ag }
define-command fzf-rg %{ open fzf-rg }
