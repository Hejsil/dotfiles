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

alias cd='__cd_alias'
alias mkdir='__mkdir_alias'
alias ls='exa -a'
alias o=open.sh
alias fo=fuzz-open.sh

alias ga='git add'
alias gc='git commit'
alias gd='git diff'
alias gds='git diff --stat'
alias gl='git log'
alias gp='git push'
alias gs='git status'

eval "$(starship init "$0")"
rsfetch -lNPdehHkrcstuU@w
