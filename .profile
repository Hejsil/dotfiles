#!/bin/sh
export PATH="/usr/share/bcc/tools/:/usr/lib/ccache/bin/:$HOME/.cache/cargo/bin:$HOME/.local/bin:$HOME/.local/script:$PATH"

# Bash history
export HISTSIZE=9999999
export HISTFILESIZE=9999999
export HISTCONTROL='ignoredups:erasedups'
export PROMPT_COMMAND='history -a; history -c; history -r'

# Programs
export BROWSER='firefox'
export EDITOR='kak'
export READER='zathura'
export TERMINAL='kitty -1'
export PAGER='less'
export WINDOW="$TERMINAL --class window"

export XDG_CACHE_HOME="$HOME/.cache"
export CARGO_HOME="$XDG_CACHE_HOME/cargo"
export CCACHE_DIR="$XDG_CACHE_HOME/ccache"
export CUDA_CACHE_PATH="$XDG_CACHE_HOME/nv"
export ERRFILE="$XDG_CACHE_HOME/x11/xsession-errors"

export XDG_DATA_HOME="$HOME/.local/share"
export GOPATH="$XDG_DATA_HOME/go"
export HISTFILE="$XDG_DATA_HOME/bash/history"
export LESSHISTFILE="$XDG_DATA_HOME/less/history"
export MACHINE_STORAGE_PATH="$XDG_DATA_HOME/docker-machine"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export TERMINFO="$XDG_DATA_HOME/terminfo"
export _ZL_DATA="$XDG_DATA_HOME/zlua"

export XDG_CONFIG_HOME="$HOME/.config"
export DOCKER_CONFIG="$XDG_CONFIG_HOME/docker"
export GNUPGHOME="$XDG_CONFIG_HOME/gnupg"
export NOTMUCH_CONFIG="$XDG_CONFIG_HOME/notmuch/notmuchrc"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export WEECHAT_HOME="$XDG_CONFIG_HOME/weechat"
export WGETRC="$XDG_CONFIG_HOME/wget/wgetrc"
export XINITRC="$XDG_CONFIG_HOME/xorg/init"

export CM_LAUNCHER='fzf'
export FZF_DEFAULT_COMMAND='fd -H --type f -S -10m'
export FZF_DEFAULT_OPTS='--no-info --color=16'
export GTK_THEME='oomox-xresources-reverse'
export LESS='-R'
export NNN_OPENER='open.sh'
export QT_QPA_PLATFORMTHEME='gtk2'
export TS_SLOTS=10000

export GTK2_RC_FILES="$HOME/.themes/$GTK_THEME/gtk-2.0/gtkrc"
export TERMINFO_DIRS="$TERMINFO:/usr/share/terminfo"
