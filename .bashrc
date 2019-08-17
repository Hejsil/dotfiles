#!/bin/sh
HISTSIZE=
HISTFILESIZE= 

__cd_alias() {
    cd "$@" || return
    exa
}

alias cd='__cd_alias'
eval "$(starship init "$0")"
