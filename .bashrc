#!/usr/bin/env bash

shopt -s histappend

__cd_alias() {
    cd "$@" || return
    exa -a
}

__mkdir_alias() {
    mkdir "$@" || return
    cd "$@"
}

alias cd='__cd_alias'
alias mkdir='__mkdir_alias'
alias ls='exa -a'
alias rg='rg --no-heading'

alias ga='git add'
alias gb='git branch'
alias gc='git commit'
alias gco='git checkout'
alias gd='git diff'
alias gds='git diff --stat'
alias gl='git log'
alias gp='git push'
alias gpl='git pull'
alias gs='git status'
alias gr='git rebase'
alias grc='git rebase --continue'

eval "$(starship init "$0")"
rsfetch -lNPdehHkrcstuU@w -p pacman
