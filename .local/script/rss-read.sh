#!/bin/sh

PROGRAM=${0##*/}
usage() {
    echo "Usage: $PROGRAM"
}

while [ -n "$1" ]; do
    case $1 in
        --) shift; break ;;
        -h|--help) usage; exit 0 ;;
        -*) usage; exit 1 ;;
        *) break ;;
    esac
    shift
done

TMP=$(mktemp)
TAB=$(printf '\t')
rss-list.sh -u |
    cut -d"$TAB" -f1,3,4 |
    awk -F"$TAB" '{ printf "%s\t%s\t%s\n", $2, $3, $1 }' |
    rofi -dmenu >"$TMP"

if [ -s "$TMP" ]; then
    cut -d"$TAB" -f2 < "$TMP" | xargs open.sh
    cut -d"$TAB" -f3 < "$TMP" | xargs -I{} mv {} "$HOME/.cache/rss/read"
fi

rm "$TMP"
