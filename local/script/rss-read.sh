#!/bin/sh

tab=$(printf '\t')
rss-list.sh -u |
    nawk -F"$tab" '{ printf "%-15s\t%s\t%s\t%s\t%s\n", substr($7, 0, 15), $3, $1, $4, $8 }' |
    fzf -m -d '\t' --with-nth=1,2 --preview 'rss-to-md.sh {3}' |
    cut -f3,4,5 | tr '\t' '\n' |
    exec xargs -d'\n' xargs tsp rss-open-read.sh
