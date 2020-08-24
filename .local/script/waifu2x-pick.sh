#!/bin/sh

program=${0##*/}
usage() {
    echo "Usage: $program"
}

noise=0
scale=2
tile=400
while [ -n "$1" ]; do
    case $1 in
        --) shift; break ;;
        -n|--noise) shift; noise=$1 ;;
        -s|--scale) shift; scale=$1 ;;
        -t|--tile) shift; tile=$1 ;;
        -h|--help) usage; exit 0 ;;
        -*) usage; exit 1 ;;
        *) break ;;
    esac
    shift
done

tmp=$(mktemp '/tmp/XXXXXXX.png')
find "$@" -type f | while read -r file; do
    waifu2x-ncnn-vulkan -i "$file" -o "$tmp" -n "$noise" -s "$scale" -t "$tile"
    printf '%s\n%s\n' "$file" "$tmp" | sxiv -fo - | xargs -I{} cp '{}' "$file"
done
rm "$tmp"
