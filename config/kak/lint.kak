# Wrapper around lint that allows multiple lint commands.
declare-option str lintcmd1
declare-option str lintcmd2

define-command set-lintcmd-window %{
    set-option window lintcmd %sh{
        printf '%s' 'run() { '
        printf '%s' "${kak_opt_lintcmd1:-true}"
        printf '%s' ' "$1" ; '
        printf '%s' "${kak_opt_lintcmd2:-true}"
        printf '%s' ' "$1" ; '
        printf '%s' '} && run'
    }
}

hook global WinSetOption lintcmd1=.* %{ set-lintcmd-window }
hook global WinSetOption lintcmd2=.* %{ set-lintcmd-window }

# Always check for typos
set-option global lintcmd1 'typos --format brief'

hook global WinSetOption filetype=sh %{
    set-option window lintcmd2 'shellcheck -f gcc'
}
hook global WinSetOption filetype=c %{
    set-option window lintcmd2 'cppcheck --language=c --enable=warning,style,information --template="{file}:{line}:{column}: {severity}: {message}" --suppress="*:*.h" --suppress="*:*.hh" 2>&1'
}
hook global WinSetOption filetype=cpp %{
    set-option window lintcmd2 'cppcheck --language=c++ --enable=warning,style,information --template="{file}:{line}:{column}: {severity}: {message}" --suppress="*:*.h" --suppress="*:*.hh" 2>&1'
}
hook global WinSetOption filetype=python %{
    set-option window lintcmd2 'pylint --msg-template="{path}:{line}:{column}: {category}: {msg}" -rn -sn'
}

hook global BufWritePre .* %{
    try lint catch %{}
}
