#!/usr/bin/env bash

source <(cod init $$ bash)
source <(starship init bash --print-full-init)
eval "$(lua /usr/share/z.lua/z.lua --init bash enhanced once)"

shopt -s histappend

__cd_alias() {
    cd "$@" || return
    exa -a
}

__ccd_alias() {
    mkdir "$@" || return
    cd "$@"
}

alias ..='__cd_alias ..'
alias ...='__cd_alias ../..'
alias .3='__cd_alias ../../..'
alias .4='__cd_alias ../../../..'

alias ccd='__ccd_alias'
alias cd='__cd_alias'

alias v='nvim'
alias vim='nvim'

alias ls='exa -a'
alias ll='exa -al'

alias cp='cp -i'

alias d='delta'
alias o='open'
alias p='patch'
alias r='replace'

alias drag='dragon-drag-and-drop'
alias gdb="gdb -nh -x '$XDG_CONFIG_HOME/gdb/init'"
alias rg='rg --no-heading'
alias trr='transmission-remote'

alias ga='git add'
alias gb='git branch --all'
alias gc='git commit'
alias gcl='git clone'
alias gco='git checkout'
alias gd='git diff'
alias gds='git diff --stat'
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

alias bro="swallow $BROWSER"
alias browser="swallow $BROWSER"

alias gimp='swallow gimp'
alias gmp='swallow gimp'

alias aud='swallow mpv -vid=no'
alias audio='swallow mpv -vid=no'
alias mp='swallow mpv'
alias mpv='swallow mpv'
alias vid='swallow mpv'
alias video='swallow mpv'

alias st='swallow st'

alias image='swallow sxiv -a'
alias img='swallow sxiv -a'
alias sx='swallow sxiv -a'
alias sxiv='swallow sxiv -a'

alias pdf='swallow zathura'
alias zat='swallow zathura'
alias zathura='swallow zathura'

