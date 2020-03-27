#!/bin/sh

set -e

program=${0##*/}
usage() {
    echo "Usage: $program [ -t time ] [ -m monitors ] folder"
}

time='1m'
while [ -n "$1" ]; do
    case $1 in
        --) shift; break ;;
        -t|--time) shift; time=$1 ;;
        -m|--monitor) shift; monitors=$1 ;;
        -h|--help) usage; exit 0 ;;
        -*) usage; exit 1 ;;
        *) break ;;
    esac
    shift
done

folder=$1; [ -z "$folder" ] && { echo 'No folder provided' >&2; exit 1; }
[ -z "$monitors" ] && monitors=$(xrandr | grep ' connected' | wc -l)
[ -z "$monitors" ] && { echo 'No amount of monitors specified' >&2; exit 1; }

# TODO: Actually use monitors variable
tmp=$(mktemp)
while true; do
    find "$folder" -type f >"$tmp" || exit 1
    sort -R "$tmp"
done | paste - - | while IFS=$(printf '\t') read -r first second; do
    if [ "$first" = "$second" ]; then
        continue
    fi

    setroot "$first" "$second"
    sleep "$time"
done
