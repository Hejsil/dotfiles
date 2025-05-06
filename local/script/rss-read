#!/bin/sh

rss-list unread |
    nawk -F '\t' '{ printf "%-14s\t%s\t%s\t%s\t%s\n", substr($7, 0, 14), $3, $1, $4, $8 }' |
    sort -k1 |
    fzf -m -d '\t' --with-nth=1,2 --preview 'COLUMNS=$FZF_PREVIEW_COLUMNS rss-to-md {3}' |
    cut -f3,4 | tr '\t' '\n' |
    exec nargs rss-open-read.sh
