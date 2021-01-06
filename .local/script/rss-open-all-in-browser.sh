#!/bin/sh

tab=$(printf '\t')
rss-list.sh -u |
    while IFS=$tab read -r file _ _ link _ _ _ enclosure; do
        printf '%s\t%s\t%s\t%s\n' "$(opener.sh "$link")" "$file" "$link" "$enclosure"
    done | grep "^$BROWSER" | head -n 50 | choose -f '\t' -o '\t' 1 -1 | tr '\t' '\n' |
    xargs -d'\n' xargs tsp rss-open-read.sh

