#!/bin/sh
export PATH="/usr/lib/ccache/bin/:$HOME/go/bin:$HOME/.local/bin:$HOME/.local/script:$PATH"

# Bash history
export HISTSIZE=
export HISTFILESIZE=
export HISTCONTROL='ignoredups:erasedups'
export PROMPT_COMMAND="history -a; history -c; history -r"

# Programs
export EDITOR='vis'
export TERMINAL='alacritty'
export BROWSER='chrome'
export READER='zathura'

export GNUPGHOME="$HOME/.config/gnupg"

export NNN_OPENER='open.sh'

export SKIM_DEFAULT_COMMAND='fd --type f'
