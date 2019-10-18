#!/bin/sh
HISTSIZE=
HISTFILESIZE= 

__cd_alias() {
    cd "$@" || return
    timeout -k 0s 1s exa -a
}

__mkdir_alias() {
    mkdir "$@" || return
    cd "$@"
}

__ls_alias() {
   exa -a "$@"
}

alias cd='__cd_alias'
alias mkdir='__mkdir_alias'
alias ls='__ls_alias'
alias o=open.sh
alias fo=fuzz-open.sh
eval "$(starship init "$0")"

pfetch
