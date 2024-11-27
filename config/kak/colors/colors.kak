# For Code
set-face global keyword blue+b
set-face global attribute blue+b
set-face global type cyan+b
set-face global value cyan+b
set-face global string green+b
set-face global function yellow+b
set-face global operator white+b
set-face global variable white
set-face global meta cyan+b
set-face global module yellow+b
set-face global builtin yellow+b
set-face global comment bright-black+i
set-face global documentation comment
set-face global InlayHint bright-black+i

# For markup
set-face global title blue
set-face global header cyan
set-face global mono green
set-face global block magenta
set-face global link cyan
set-face global bullet cyan
set-face global list yellow

# builtin faces
set-face global Default default,default
set-face global PrimarySelection white,blue+fg
set-face global SecondaryCursorEol black,cyan+fg
set-face global LineNumbers default,default
set-face global LineNumberCursor default,default+r
set-face global MenuForeground white,bright-black
set-face global MenuBackground white,black
set-face global MenuInfo cyan
set-face global Information black,yellow
set-face global Error black,red
set-face global StatusLine cyan,default
set-face global StatusLineMode yellow,default
set-face global StatusLineInfo blue,default
set-face global StatusLineValue green,default
set-face global StatusCursor black,cyan
set-face global Prompt yellow,default
set-face global MatchingChar default,default+bi
set-face global Whitespace default,default+f
set-face global BufferPadding blue,default

set-face global PrimaryCursor      black,cyan+fg
set-face global SecondaryCursor    black,cyan+fg
set-face global PrimaryCursorEol   black,cyan+fg
set-face global SecondarySelection black,blue+fg

# https://discuss.kakoune.com/t/changing-the-cursor-colour-in-insert-mode/394/4
# Change cursor color based on mode
hook global ModeChange .*:insert  %{
    set-face global PrimaryCursor    black,white+fg
    set-face global SecondaryCursor  black,white+fg
    set-face global PrimaryCursorEol black,white+fg
}
hook global ModeChange .*:normal  %{
    set-face global PrimaryCursor    black,cyan+fg
    set-face global SecondaryCursor  black,cyan+fg
    set-face global PrimaryCursorEol black,cyan+fg
}
