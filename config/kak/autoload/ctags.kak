hook global WinSetOption filetype=.* %{
    # Only have ctags autocomplete enables for c files
    ctags-disable-autocomplete
}

hook global WinSetOption filetype=c %{
    ctags-enable-autocomplete

    map buffer goto d '<esc>eb:ctags-search<ret>' -docstring 'definition'

    hook buffer BufWritePost .* %{ ctags-generate }
}


