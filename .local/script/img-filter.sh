#!/bin/sh

PROGRAM=${0##*/}
usage() {
    echo "usage: $PROGRAM [ -r RATIO ] [ -n RATIO ] [ -l PIXELS ] [ -g PIXELS ] [-h]"
}

while [ -n "$1" ]; do
    case $1 in
        --) shift; break ;;
        -h|--help) usage; exit 0 ;;
        -r|--ratio) shift; RATIO=$1 ;;
        -n|--not-ratio) shift; NOT_RATIO=$1 ;;
        -l|--least) shift; LEAST=$1 ;;
        -g|--greater) shift; GREATER=$1 ;;
        -w|--least-width) shift; least_width=$1 ;;
        -*) usage; exit 1 ;;
        *) break ;;
    esac
    shift
done

find "$@" -type f | while read -r FILE; do
    identify -format '%w %h ' "$FILE" | {
        read -r W H _

        if [ -n "$NOT_RATIO" ] && ! [ "$(echo "$W/$H" | bc -l)" = "$NOT_RATIO" ]; then
            echo "$FILE"
        elif [ -n "$RATIO" ] && [ "$(echo "$W/$H" | bc -l)" = "$RATIO" ]; then
            echo "$FILE"
        elif [ -n "$LEAST" ] && [ "$(( $W * $H ))" -lt "$LEAST" ]; then
            echo "$FILE"
        elif [ -n "$GREATER" ] && ! [ "$(( $W * $H ))" -lt "$GREATER" ]; then
            echo "$FILE"
        elif [ -n "$least_width" ] && [ "$W" -lt "$least_width" ]; then
            echo "$FILE"
        fi
    }
done
