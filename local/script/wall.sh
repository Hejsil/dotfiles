#!/bin/sh -e

folder=$1
screens=$(mktemp)
images=$(mktemp)

xrandr --listactivemonitors |
    rg -o '^ \d+: [^ ]+ \d+/\d+x\d+.*  (.+)$' -r '$1' >"$screens"
count=$(wc -l <"$screens")

find "$folder" -type f | sort -R | head -n "$count" >"$images"

paste "$screens" "$images" |
    nawk '{printf "--output\n%s\n--zoom\n%s\n", $1, $2 }' |
    xargs -d '\n' xwallpaper

rm "$screens"
rm "$images"
