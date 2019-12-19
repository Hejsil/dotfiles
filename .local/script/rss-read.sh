#!/bin/sh

PROGRAM="$(basename "$0")"
usage() {
    echo "Usage: $(basename "$PROGRAM")"
}

while getopts "h" OPT; do
    case "$OPT" in
        h)
            usage
            exit 0
            ;;
        *)
            usage
            exit 1
            ;;
    esac
done
shift $((OPTIND-1))

TMP="$(mktemp)"
TAB="$(printf '\t')"
find "$HOME/.cache/rss/unread/" -type f | while read -r FILE; do
    tr '\n' '\t' < "$FILE"
    printf "%s\n" "$FILE"
done | cut -d"$TAB" -f2,3,8 | rofi -dmenu >"$TMP"

if [ -s "$TMP" ]; then
    cut -d"$TAB" -f2 < "$TMP" | xargs open.sh
    cut -d"$TAB" -f3 < "$TMP" | xargs -I{} mv {} "$HOME/.cache/rss/read"
fi

rm "$TMP"
