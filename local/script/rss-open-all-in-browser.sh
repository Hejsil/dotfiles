#!/bin/sh

tab=$(printf '\t')
rss-list.sh -u | cut -f1,4,8 |
    # Some links can be modified to open better
    sd 'https://nyaa.si/download/(\w+).torrent' 'https://nyaa.si/view/$1' |
    sd 'https://www.dr.dk/lyd/p4/radioavisen/[a-zA-Z0-9-]*' '' |
    while IFS=$tab read -r file link enclosure; do
        printf '%s\t%s\t%s\t%s\n' "$(printf '%s\t\n' "$link" | opener)" "$file" "$link" "$enclosure"
    done | grep "^$BROWSER" | head -n 5 | cut -f2,3,4 | tr '\t' '\n' |
    exec xargs -d'\n' xargs tsp rss-open-read.sh
