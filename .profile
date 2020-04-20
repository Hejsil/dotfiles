#!/bin/sh
export PATH="/usr/lib/ccache/bin/:$HOME/.local/bin:$HOME/.local/script:$PATH"

# Bash history
export HISTSIZE=
export HISTFILESIZE=
export HISTCONTROL='ignoredups:erasedups'
export PROMPT_COMMAND="history -a; history -c; history -r"

# Programs
export EDITOR='vis'
export TERMINAL='st'
export BROWSER='chromium'
export READER='zathura'

export GNUPGHOME="$HOME/.config/gnupg"
export LESSHISTFILE="$HOME/.cache/less/history"
export CCACHE_DIR="$HOME/.cache/ccache"
export CARGO_HOME="$HOME/.cache/cargo"
export GTK2_RC_FILES="$HOME/.config/gtk-2.0/gtkrc-2.0"
export HISTFILE="$HOME/.local/share/bash/history"
export NOTMUCH_CONFIG="$HOME/.config/notmuch/notmuchrc"
export WGETRC="$HOME/.config/wget/wgetrc"
export CUDA_CACHE_PATH="$HOME/.cache/nv"
export TERMINFO="$HOME/.local/share/terminfo"
export TERMINFO_DIRS="$TERMINFO:/usr/share/terminfo"

export NNN_OPENER='open.sh'

export FZF_DEFAULT_COMMAND='fd -H --type f'
export FZF_DEFAULT_OPTS='--info=hidden --color=16'
