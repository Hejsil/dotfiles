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
rss-list.sh -u |
    cut -d"$TAB" -f1,3,4 |
    awk -F"$TAB" '{ printf "%s\t%s\t%s\n", $2, $3, $1 }' |
    rofi -dmenu >"$TMP"

if [ -s "$TMP" ]; then
    cut -d"$TAB" -f2 < "$TMP" | xargs open.sh
    cut -d"$TAB" -f3 < "$TMP" | xargs -I{} mv {} "$HOME/.cache/rss/read"
fi

rm "$TMP"
