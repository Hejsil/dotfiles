declare-option -docstring "Shell command to autocomplete as you type" \
    str autocompletecmd

declare-option -docstring "Same as autocompletecmd and is run after it" \
    str autocompletecmd2

define-command autocomplete -params 1 -docstring "" %{
    evaluate-commands %sh{
        if ! command -v "$1" >/dev/null; then
            echo "fail 'No command called ''$1'' in PATH'"
        fi
        if [ "$(echo "$kak_selections_length" | grep -c ' ')" != 0 ]; then
            echo "fail 'Cannot autocomplete while having multiple selections'"
        fi
    }
    execute-keys -draft "<a-;>h<a-;>Gh<a-;>|%arg[1]<ret>"
    execute-keys -save-regs '"' '<a-;><a-f>¤<a-;>;<a-;>d'
}

hook global -group autocomplete InsertChar '[^\w\n.]' %{
    try %{ autocomplete %opt{autocompletecmd} } catch %{}
    try %{ autocomplete %opt{autocompletecmd2} } catch %{}
}

hook global WinSetOption filetype=(c|cpp) %{ set-option window autocompletecmd 'c-autocomplete' }
hook global WinSetOption filetype=html    %{ set-option window autocompletecmd 'html-autocomplete' }
hook global WinSetOption filetype=rust    %{ set-option window autocompletecmd 'rust-autocomplete' }
hook global WinSetOption filetype=zig     %{ set-option window autocompletecmd 'zig-autocomplete' }

