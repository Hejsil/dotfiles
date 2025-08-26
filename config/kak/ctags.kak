
hook global WinSetOption filetype=(python|c|cpp) %{
    set-option buffer ctagspaths "src lib deps"
    hook buffer BufWritePost .* %{ ctags-generate }
}
