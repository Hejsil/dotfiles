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
rss-list.sh -u |
    cut -d"$tab" -f1,3,4,7 |
    awk -F"$tab" '{ printf "%-60s\t%-20s\t%s\t%s\n", substr($2, 0, 60), substr($4, 0, 20), $3, $1 }' |
    rofi -dmenu >"$tmp"

if [ -s "$tmp" ]; then
    cut -d"$tab" -f3 "$tmp" | xargs open.sh
    cut -d"$tab" -f4 "$tmp" | xargs -I{} mv {} "$HOME/.cache/rss/read"
fi

rm "$tmp"
