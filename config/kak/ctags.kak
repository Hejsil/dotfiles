hook global WinSetOption filetype=(python) %{
    hook buffer BufWritePost .* %{ ctags-generate }
}
