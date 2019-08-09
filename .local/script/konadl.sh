#!/bin/sh

SITE_LINK="$1"; [ -z "$SITE_LINK" ] && echo "No link provided" && exit 1

seq 0 1000000000 | while read I; do
    curl "$SITE_LINK/post.json?page=$I" 2>/dev/null |
        jq '.[].file_url' |
        sed -E 's/"(.*)"/\1/' |
        while read LINK
    do
        FILE="$(mktemp "XXXXXXXXXX")"
        curl "$LINK" --output "$FILE" 2>/dev/null
    done

    FILES="$(ls | wc)"
    echo "$FILES"
    if [ "$FILES" = "$FILES_LAST" ]; then
        exit 0
    fi
    FILES_LAST="$FILES"
done
