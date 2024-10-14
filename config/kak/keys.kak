# Moving lines
define-command -override move-lines-down -docstring 'move line down' %{
    execute-keys -draft 'x<a-_><a-:>Z;ezjxdzP'
}

define-command -override move-lines-up -docstring 'move line up' %{
    execute-keys -draft 'x<a-_><a-:><a-;>Z;bzkxdzp'
}

map global user c ':comment-line<ret>'      -docstring 'Comment out line'
map global user y '<a-|>clipcopy<ret>'      -docstring 'Copy to system clipboard'
map global user p '!clippaste<ret>'         -docstring 'Paste from system clipboard'
map global user S '|sort<ret>'              -docstring 'Sort'
map global user R '|sort -r<ret>'           -docstring 'Sort reverse'

map global insert <pageup>   '<a-;><c-b>'
map global insert <pagedown> '<a-;><c-f>'

map global normal "'"           '<a-i>w*/<ret>'
map global normal 'z'           ':w<ret>'

# Default to case insensitive search
map global normal '/'           '/(?i)'
map global normal '?'           '?(?i)'

# I fumble to much and hit `u` when I want to press `i`. Rebind so that
# <ret> goes to insert mode and <backspace> undoes
map global normal '<ret>'       'i'
map global normal '<backspace>' 'u'
map global normal 'u'           '<ret>'
map global normal 'i'           '<ret>'

map global normal '<a-down>' ':move-lines-down<ret>'
map global normal '<a-up>'   ':move-lines-up<ret>'
map global insert '<a-down>' '<a-;>:move-lines-down<ret>'
map global insert '<a-up>'   '<a-;>:move-lines-up<ret>'

map global insert '<c-o>' '<a-;>o'

# Revert some changes kakoune did to the bindings. My muscle memory is to strong for
# me to adabt to these changes.
map global normal ',' '<space>'
map global normal '<space>' ','

# Auto complete with tab
hook global InsertCompletionShow .* %{ map window insert <tab> <c-n> }
hook global InsertCompletionHide .* %{ map window insert <tab> <tab> }
