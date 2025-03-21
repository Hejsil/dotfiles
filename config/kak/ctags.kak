hook global WinSetOption filetype=.* %{
    # Only have ctags autocomplete enables for c files
    ctags-disable-autocomplete
}

hook global WinSetOption filetype=(python|c|cpp) %{
    ctags-enable-autocomplete

    map buffer goto d '<esc><a-i>w:ctags-search<ret>' -docstring 'definition'

    hook buffer BufWritePost .* %{ ctags-generate }
}


