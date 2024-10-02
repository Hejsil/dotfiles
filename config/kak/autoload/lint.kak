hook global WinSetOption filetype=sh %{ set-option window lintcmd 'shellcheck -f gcc' }
hook global WinSetOption filetype=c %{
    set-option window lintcmd 'cppcheck --language=c --enable=warning,style,information --template="{file}:{line}:{column}: {severity}: {message}" --suppress="*:*.h" --suppress="*:*.hh" 2>&1'
}
hook global WinSetOption filetype=cpp %{
    set-option window lintcmd 'cppcheck --language=c++ --enable=warning,style,information --template="{file}:{line}:{column}: {severity}: {message}" --suppress="*:*.h" --suppress="*:*.hh" 2>&1'
}
hook global WinSetOption filetype=python %{
    set-option window lintcmd 'pylint --msg-template="{path}:{line}:{column}: {category}: {msg}" -rn -sn'
}

