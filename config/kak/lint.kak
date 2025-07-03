# Wrapper around lint that allows multiple lint commands.
# To add a new one, first add it here
declare-option str lintcmd1
declare-option str lintcmd2
declare-option str lintcmd3
declare-option str lintcmd4

define-command set-lintcmd-window %{
    set-option window lintcmd %sh{
        # Then here
        printf '%s' 'run() { '
        printf '%s' "${kak_opt_lintcmd1:-true}"
        printf '%s' ' "$1"; '
        printf '%s' "${kak_opt_lintcmd2:-true}"
        printf '%s' ' "$1"; '
        printf '%s' "${kak_opt_lintcmd3:-true}"
        printf '%s' ' "$1"; '
        printf '%s' "${kak_opt_lintcmd4:-true}"
        printf '%s' ' "$1"; '
        printf '%s' '} && run'
    }
}

hook global WinSetOption 'lintcmd\d+=.*' %{ set-lintcmd-window }

# Always check for typos
# set-option global lintcmd1 'typos --format brief'

hook global WinSetOption filetype=sh %{
    set-option window lintcmd2 'shellcheck -f gcc'
}
hook global WinSetOption filetype=c %{
    set-option window lintcmd2 'cppcheck --language=c --enable=all --template="{file}:{line}:{column}: {severity}: {message}" 2>&1'
    set-option window lintcmd3 'rg -HU --column "^ *\w+(( *\*)+ *| +)\w+ *\( *\)[ \n]*\{" -r " warning: empty parameter list"'
    # } To balance the brackets. In the rg pattern there is the opening bracket
}
hook global WinSetOption filetype=cpp %{
    set-option window lintcmd2 'cppcheck --language=c++ --enable=all --template="{file}:{line}:{column}: {severity}: {message}" --suppress="*:*.h" 2>&1'
    set-option window lintcmd3 'rg -HU --column "^ *\w+(( *\*)+ *| +)\w+ *\( *\)[ \n]*\{" -r " warning: empty parameter list"'
    # } To balance the brackets. In the rg pattern there is the opening bracket
}
hook global WinSetOption filetype=python %{
    set-option window lintcmd2 'pylint --msg-template="{path}:{line}:{column}: {category}: {msg}" -rn -sn'
    set-option window lintcmd3 'run2() { ruff check "$1" | rg "(^[^:]*:\d+:\d+:) F\d+( \[\*\])?" -r "\$1 warning:" ; } && run2'
    set-option window lintcmd4 'pycodestyle --max-line-length=100'
}

hook global BufWritePre .* %{
    try %sh{
        if [ -z "$kak_opt_lintcmd1" ] &&  [ -z "$kak_opt_lintcmd2" ] && [ -z "$kak_opt_lintcmd3" ]; then
            echo nop
        else
            echo lint
    } catch %{}
}
