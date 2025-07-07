hook global WinSetOption filetype=sh %{
    set-option buffer lintcmd 'shellcheck -f gcc'
}

hook global BufWritePre .* %{
    try lint catch %{}
}
