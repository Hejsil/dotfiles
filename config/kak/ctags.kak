hook global WinSetOption filetype=.* %{
    ctags-disable-autocomplete
}

hook global WinSetOption filetype=(python) %{
    ctags-enable-autocomplete

    map buffer goto d '<esc><a-i>w:ctags-search<ret>' -docstring 'definition'

    hook buffer BufWritePost .* %{ ctags-generate }
}
