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

__kak_alias() {
    session_id=$(pwd | sha1sum | cut -d' ' -f1)
    kak -c "$session_id" $@ || kak -s "$session_id" $@
}

gst() { (
    source deps/env.sh
    source dddq_environment.sh
    RUST_BACKTRACE=1 GST_PLUGIN_PATH="$(pwd)/target/debug:$GST_PLUGIN_PATH" GST_DEBUG_DUMP_DOT_DIR=dot "$@"
) }

alias ..='__cd_alias ..'
alias ...='__cd_alias ../..'
alias .3='__cd_alias ../../..'
alias .4='__cd_alias ../../../..'

alias ccd='__ccd_alias'
alias cd='__cd_alias'
alias c='__cd_alias'

alias kak='__kak_alias'
alias k='__kak_alias'

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

