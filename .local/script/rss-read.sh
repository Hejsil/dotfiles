#!/bin/sh

tab=$(printf '\t')
rss-list.sh -u |
    awk -F"$tab" '{ printf "%-60s\t%-15s\t%s\t%s\t%s\n", substr($3, 0, 60), substr($7, 0, 15), $1, $4, $8 }' |
    fzf -m -d '\t' --with-nth=1,2 | cut -f3,4,5 | tr '\t' '\n' |
    xargs -d'\n' xargs tsp rss-open-read.sh

