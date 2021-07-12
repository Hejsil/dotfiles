#!/usr/bin/env bash

source <(cod init $$ bash)
source <(starship init bash --print-full-init)
eval "$(direnv hook bash)"
eval "$(zoxide init bash)"

# if this is interactive shell, then bind hstr to Ctrl-r (for Vi mode check doc)
# if this is interactive shell, then bind 'kill last command' to Ctrl-x k
if [[ $- =~ .*i.* ]]; then bind '"\C-r": "\C-a hstr -- \C-j"'; fi
if [[ $- =~ .*i.* ]]; then bind '"\C-xk": "\C-a hstr -k \C-j"'; fi

shopt -s histappend

__cd_alias() {
    z "$@" || return
    timeout -k 0 0.1s exa
}

__ccd_alias() {
    mkdir "$@" || return
    __cd_alias "$@"
}

__kak_alias() {
    session_id=$(pwd | sha1sum | cut -d' ' -f1)

    kak -c "$session_id" "$@" ||
        kak -s "$session_id" "$@"
}

alias ..='__cd_alias ..'
alias ...='__cd_alias ../..'
alias .3='__cd_alias ../../..'
alias .4='__cd_alias ../../../..'

alias ccd='__ccd_alias'
alias cd='__cd_alias'
alias c='__cd_alias'

alias kak='__kak_alias'

alias df='duf'
alias ll='exa -al'
alias ls='exa -a'

alias cp='cp -i'
alias man='fzf-man'
alias map='xargs -d"\n"'
alias mv='mv -i'
alias o='open'
alias r='ranger'

alias ab='autobuild'
alias cb='cargo build'
alias zb='zig build'

alias drag='dragon-drag-and-drop'
alias gdb='gdb -nh -x "$XDG_CONFIG_HOME/gdb/init"'
alias rg='rg --no-heading'
alias trr='transmission-remote'

alias ga='git add'
alias gap='git add --patch'
alias gb='git branch --all'
alias gc='git commit'
alias gca='git commit --amend'
alias gcl='git clone --recursive'
alias gcn='git commit --no-verify'
alias gco='git checkout'
alias gcop='git checkout --patch'
alias gd='git diff'
alias gds='git diff --staged'
alias gf='git fetch'
alias gl='git log --graph --oneline'
alias gp='git push'
alias gpl='git pull'
alias gr='git rebase'
alias grc='git rebase --continue'
alias gs='git status'
alias gsh='git stash'
