#!/bin/sh
HISTSIZE= HISTFILESIZE= 

FG_BLACK="\[$(tput setaf 0)\]"
FG_RED="\[$(tput setaf 1)\]"
FG_GREEN="\[$(tput setaf 2)\]"
FG_YELLOW="\[$(tput setaf 3)\]"
FG_BLUE="\[$(tput setaf 4)\]"
FG_MAGENTA="\[$(tput setaf 5)\]"
FG_CYAN="\[$(tput setaf 6)\]"
FG_WHITE="\[$(tput setaf 7)\]"
FG_GREY="\[$(tput setaf 8)\]"

BG_BLACK="\[$(tput setab 0)\]"
BG_RED="\[$(tput setab 1)\]"
BG_GREEN="\[$(tput setab 2)\]"
BG_YELLOW="\[$(tput setab 3)\]"
BG_BLUE="\[$(tput setab 4)\]"
BG_MAGENTA="\[$(tput setab 5)\]"
BG_CYAN="\[$(tput setab 6)\]"
BG_WHITE="\[$(tput setab 7)\]"
BG_GREY="\[$(tput setab 8)\]"

BOLD="\[$(tput bold)\]"

RESET="\[$(tput sgr0)\]"

__bash_prompt_command() {
    EXIT_CODE="$?"
    WORKING_DIR="$(pwd | sd "$HOME" "~")"
    PS1="\n${BOLD}${FG_BLUE}${WORKING_DIR}${RESET}"

    if git rev-parse --is-inside-work-tree &>/dev/null; then
        GIT_BRANCH="$(git branch --show-current)"
        GIT_DIRTY="$(git diff --quiet --ignore-submodules HEAD &>/dev/null || echo "*")"
        PS1+=" ${BOLD}${FG_GREY}${GIT_BRANCH}${GIT_DIRTY}${RESET}"
    fi

    PS1+="\n${BOLD}${FG_GREY}[${EXIT_CODE}]${RESET} "
}

PROMPT_COMMAND="__bash_prompt_command"
