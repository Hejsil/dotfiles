#!/bin/sh

tab=$(printf '\t')
rss-list unread |
    nawk -F"$tab" '{ printf "%-14s\t%s\t%s\t%s\t%s\n", substr($7, 0, 14), $3, $1, $4, $8 }' |
    fzf -m -d '\t' --with-nth=1,2 --preview 'COLUMNS=$FZF_PREVIEW_COLUMNS rss-to-md {3}' |
    cut -f3,4,5 | tr '\t' '\n' |
    exec xargs -d'\n' xargs systemd-run --user rss-open-read.sh
