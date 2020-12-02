#!/usr/bin/env bash

source <(starship init bash --print-full-init)
eval "$(zoxide init bash)"

shopt -s histappend

__cd_alias() {
    z "$@" || return
    timeout -k 0 0.1s exa -a
}

__ccd_alias() {
    mkdir "$@" || return
    __cd_alias "$@"
}

alias ..='__cd_alias ..'
alias ...='__cd_alias ../..'
alias .3='__cd_alias ../../..'
alias .4='__cd_alias ../../../..'

alias ccd='__ccd_alias'
alias cd='__cd_alias'
alias c='__cd_alias'

alias k='kak'

alias v='nvim'
alias vim='nvim'

alias ls='exa -a'
alias ll='exa -al'

alias cp='cp -i'
alias rm='rip'

alias d='delta'
alias o='open'
alias p='patch'
alias r='replace'

alias drag='dragon-drag-and-drop'
alias gdb="gdb -nh -x '$XDG_CONFIG_HOME/gdb/init'"
alias rg='rg --no-heading'
alias trr='transmission-remote'

alias ga='git add'
alias gap='git add --patch'
alias gb='git branch --all'
alias gc='git commit'
alias gcl='git clone'
alias gco='git checkout'
alias gd='git diff'
alias gds='git diff --staged'
alias gf='git fetch'
alias gf='git fetch'
alias gl='git log --graph --oneline'
alias gp='git push'
alias gpl='git pull'
alias gr='git rebase'
alias grc='git rebase --continue'
alias gs='git status'
alias gsh='git stash'

alias dc='sudo docker-compose'
alias dcd='sudo docker-compose down'
alias dcl='sudo docker-compose logs'
alias dcp='sudo docker-compose pull'
alias dcr='sudo docker-compose restart'
alias dcs='sudo docker-compose stop'
alias dcu='sudo docker-compose up'
alias dcx='sudo docker-compose exec'

