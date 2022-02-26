#!/bin/sh

tab=$(printf '\t')
rss-list.sh -u | cut -f1,4,8 |
    while IFS=$tab read -r file link enclosure; do
        printf '%s\t%s\t%s\t%s\n' "$(printf '%s\t\n' "$link" | opener.sh)" "$file" "$link" "$enclosure"
    done | grep "^$BROWSER" | head -n 50 | cut -f2,3,4 | tr '\t' '\n' |
    exec xargs -d'\n' xargs tsp rss-open-read.sh
