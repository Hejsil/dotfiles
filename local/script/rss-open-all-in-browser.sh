#!/bin/sh

tab=$(printf '\t')
rss-list unread | cut -f1,4,8 |
    while IFS=$tab read -r file link enclosure; do
        printf '%s\t%s\t%s\t%s\n' "$(echo "$link" | opener)" "$file" "$link" "$enclosure"
    done | grep "^browser\s" | cut -f2,3,4 | sort -R | head -n10 | tr '\t' '\n' |
    exec xargs -d'\n' xargs systemd-run --user rss-open-read.sh
