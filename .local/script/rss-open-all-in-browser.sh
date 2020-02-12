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
rss-list.sh -u | cut -d"$TAB" -f1,4 |
while IFS=$TAB read -r FILE LINK; do
    printf '%s\t%s\t%s\n' "$(opener.sh "$LINK")" "$FILE" "$LINK"
done | grep "^$BROWSER" | cut -d"$TAB" -f2,3 | head -n 50 >"$TMP"

if [ -s "$TMP" ]; then
    cut -d"$TAB" -f2 < "$TMP" | tr '\n' ' ' | xargs "$BROWSER" &
    cut -d"$TAB" -f1 < "$TMP" | xargs -I{} mv {} "$HOME/.cache/rss/read" &
    wait
fi

rm "$TMP"
