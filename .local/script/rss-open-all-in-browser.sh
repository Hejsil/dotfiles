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
rss-list.sh -u | cut -d"$TAB" -f1,4 |
while IFS="$TAB" read -r FILE LINK; do
    printf "%s\t%s\t%s\n" "$(opener.sh "$LINK")" "$FILE" "$LINK"
done | grep "^$BROWSER" | cut -d"$TAB" -f2,3 | head -n 50 >"$TMP"

if [ -s "$TMP" ]; then
    cut -d"$TAB" -f2 < "$TMP" | tr '\n' ' ' | xargs "$BROWSER" &
    cut -d"$TAB" -f1 < "$TMP" | xargs -I{} mv {} "$HOME/.cache/rss/read" &
    wait
fi

rm "$TMP"
