#!/bin/sh
export ZSH=/usr/share/oh-my-zsh
export LANG=en_DK.UTF-8

export PATH="$PATH:$HOME/.scripts"
export PATH="$PATH:$HOME/.bin"

ZSH_THEME="refined"
CASE_SENSITIVE="true"
DISABLE_AUTO_UPDATE="true"
COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="yyyy-mm-dd"

plugins=(
  git
)

source $ZSH/oh-my-zsh.sh
source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

bindkey "^[[3~" delete-char
bindkey "^[[3;5~" delete-word
bindkey "^H" backward-delete-word
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line
bindkey "^[[1;5D" backward-word
bindkey "^[[1;5C" forward-word
bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search

alias open="xdg-open \$(sk)"
