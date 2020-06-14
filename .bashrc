#!/usr/bin/env bash

shopt -s histappend


__bash_prompt_command() {
    local exit_code=$?
    local fg_black="\[$(tput setaf 0)\]"
    local fg_red="\[$(tput setaf 1)\]"
    local fg_green="\[$(tput setaf 2)\]"
    local fg_yellow="\[$(tput setaf 3)\]"
    local fg_blue="\[$(tput setaf 4)\]"
    local fg_magenta="\[$(tput setaf 5)\]"
    local fg_cyan="\[$(tput setaf 6)\]"
    local fg_white="\[$(tput setaf 7)\]"
    local fg_grey="\[$(tput setaf 8)\]"

    local bg_black="\[$(tput setab 0)\]"
    local bg_red="\[$(tput setab 1)\]"
    local bg_green="\[$(tput setab 2)\]"
    local bg_yellow="\[$(tput setab 3)\]"
    local bg_blue="\[$(tput setab 4)\]"
    local bg_magenta="\[$(tput setab 5)\]"
    local bg_cyan="\[$(tput setab 6)\]"
    local bg_white="\[$(tput setab 7)\]"
    local bg_grey="\[$(tput setab 8)\]"

    local bold="\[$(tput bold)\]"
    local reset="\[$(tput sgr0)\]"

    local a=$(printf "\a")
    local cwd=$(pwd | sed "s$a^$HOME$a~$a" | sed -E "s$a.*/([^/]*/[^/]*/[^/]*\$)$a\1$a")
    PS1="\n${bold}${fg_blue}${cwd}${reset}"

    if git rev-parse --is-inside-work-tree &>/dev/null; then
        local fallback=$(timeout 0.1s git log --oneline -n 1 --decorate=short 2>/dev/null | cut -d')' -f1 | sed 's/ (HEAD// ; s/ //g' | rev | cut -d, -f1 | rev)
        local branch=$(timeout 0.1s git branch --show-current)
        local dirty=$(timeout 0.1s git diff --quiet --ignore-submodules HEAD &>/dev/null || echo "*")
        PS1+=" ${bold}${fg_grey}${branch:-${fallback:-???}}${dirty}${reset}"
    fi

    case $exit_code in
        0) prompt_color=$fg_green ;;
        *) prompt_color=$fg_red ;;
    esac

    PS1+="\n${bold}${prompt_color}\$${reset} "
}

PROMPT_COMMAND="${PROMPT_COMMAND};__bash_prompt_command"

__cd_alias() {
    cd "$@" || return
    exa -a
}

__ccd_alias() {
    mkdir "$@" || return
    cd "$@"
}

alias cd='__cd_alias'
alias ccd='__ccd_alias'
alias ls='exa -a'
alias rg='rg --no-heading'
alias gdb="gdb -nh -x '$XDG_CONFIG_HOME/gdb/init'"

alias ga='git add'
alias gb='git branch'
alias gc='git commit'
alias gcl='git clone'
alias gco='git checkout'
alias gd='git diff'
alias gds='git diff --stat'
alias gl='git log --graph --oneline'
alias gp='git push'
alias gpl='git pull'
alias gs='git status'
alias gr='git rebase'
alias grc='git rebase --continue'

rsfetch -lNPdehHkrcstuU@w -p pacman
