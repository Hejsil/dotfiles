hook global WinSetOption filetype=(python|c|cpp) %{
    hook buffer BufWritePost .* %{ ctags-generate }
}
