#!/bin/sh

usage() {
    echo "img-filter.sh [ -r RATIO ] [ -n RATIO ] [ -l PIXELS ] [ -g PIXELS ] [-h]"
}

while getopts "r:l:n:g:h" OPT; do
    case "$OPT" in
        r) RATIO="$(echo "$OPTARG" | bc -l)" ;;
        n) NOTRATIO="$(echo "$OPTARG" | bc -l)" ;;
        l) LEAST="$(echo "$OPTARG" | bc -l)" ;;
        g) GREATER="$(echo "$OPTARG" | bc -l)" ;;
        h) 
            usage
            exit 0
            ;;
        *) ;;
    esac
done
shift $((OPTIND-1))

find "$@" -type f | while read -r FILE; do
    identify -format "%w %h " "$FILE" | (
        read -r W H REST
        #echo "$FILE $W $H"

        if [ -n "$NOTRATIO" ] && ! [ "$(echo "$W/$H" | bc -l)" = "$NOTRATIO" ]; then
            echo "$FILE"
        elif [ -n "$RATIO" ] && [ "$(echo "$W/$H" | bc -l)" = "$RATIO" ]; then
            echo "$FILE"
        elif [ -n "$LEAST" ] && [ "$(echo "$W*$H" | bc -l)" -lt "$LEAST" ]; then
            echo "$FILE"
        elif [ -n "$GREATER" ] && ! [ "$(echo "$W*$H" | bc -l)" -lt "$GREATER" ]; then
            echo "$FILE"
        fi
    )
done
