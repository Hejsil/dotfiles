#!/bin/sh

program=${0##*/}
usage() {
    echo "Usage: $program"
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

tmp=$(mktemp)
tab=$(printf '\t')
rss-list.sh -u | cut -d"$tab" -f1,4 |
while IFS=$tab read -r FILE LINK; do
    printf '%s\t%s\t%s\n' "$(opener.sh "$LINK")" "$FILE" "$LINK"
done | grep "^$BROWSER" | cut -d"$tab" -f2,3 | head -n 50 >"$tmp"

if [ -s "$tmp" ]; then
    cut -d"$tab" -f2 < "$tmp" | tr '\n' ' ' | xargs "$BROWSER" &
    cut -d"$tab" -f1 < "$tmp" | xargs -I{} mv {} "$HOME/.cache/rss/read" &
    wait
fi

rm "$tmp"
