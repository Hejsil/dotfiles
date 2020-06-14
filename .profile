#!/bin/sh
export PATH="/usr/lib/ccache/bin/:$HOME/.local/bin:$HOME/.local/script:$PATH"

# Bash history
export HISTSIZE=9999999
export HISTFILESIZE=9999999
export HISTCONTROL='ignoredups:erasedups'
export PROMPT_COMMAND="history -a; history -c; history -r"

# Programs
export EDITOR='nvim'
export TERMINAL='st'
export BROWSER='chromium'
export READER='zathura'

export XDG_CACHE_HOME="$HOME/.cache"
export LESSHISTFILE="$XDG_CACHE_HOME/less/history"
export CCACHE_DIR="$XDG_CACHE_HOME/ccache"
export CARGO_HOME="$XDG_CACHE_HOME/cargo"
export CUDA_CACHE_PATH="$XDG_CACHE_HOME/nv"

export XDG_DATA_HOME="$HOME/.local/share"
export HISTFILE="$XDG_DATA_HOME/bash/history"
export TERMINFO="$XDG_DATA_HOME/terminfo"

export XDG_CONFIG_HOME="$HOME/.config"
export GNUPGHOME="$XDG_CONFIG_HOME/gnupg"
export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc-2.0"
export NOTMUCH_CONFIG="$XDG_CONFIG_HOME/notmuch/notmuchrc"
export WGETRC="$XDG_CONFIG_HOME/wget/wgetrc"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"

export TERMINFO_DIRS="$TERMINFO:/usr/share/terminfo"

export NNN_OPENER='open.sh'

export FZF_DEFAULT_COMMAND='fd -H --type f'
export FZF_DEFAULT_OPTS='--info=hidden --color=16'
