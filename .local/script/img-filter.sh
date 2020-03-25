#!/bin/sh

program=${0##*/}
usage() {
    echo "usage: $program [ -r ratio ] [ -n ratio ] [ -l PIXELS ] [ -g PIXELS ] [-h]"
}

while [ -n "$1" ]; do
    case $1 in
        --) shift; break ;;
        -h|--help) usage; exit 0 ;;
        -r|--ratio) shift; ratio=$1 ;;
        -n|--not-ratio) shift; not_ratio=$1 ;;
        -l|--least) shift; least=$1 ;;
        -g|--greater) shift; greater=$1 ;;
        -w|--least-width) shift; least_width=$1 ;;
        -*) usage; exit 1 ;;
        *) break ;;
    esac
    shift
done

find "$@" -type f | while read -r file; do
    identify -format '%w %h ' "$file" | {
        read -r W H _

        if [ -n "$not_ratio" ] && ! [ "$(echo "$W/$H" | bc -l)" = "$not_ratio" ]; then
            echo "$file"
        elif [ -n "$ratio" ] && [ "$(echo "$W/$H" | bc -l)" = "$ratio" ]; then
            echo "$file"
        elif [ -n "$least" ] && [ "$((W * H))" -lt "$least" ]; then
            echo "$file"
        elif [ -n "$greater" ] && ! [ "$((W * H))" -lt "$greater" ]; then
            echo "$file"
        elif [ -n "$least_width" ] && [ "$W" -lt "$least_width" ]; then
            echo "$file"
        fi
    }
done
