#!/bin/sh

PROGRAM="$(basename "$0")"
usage() {
    echo "Usage: $(basename "$PROGRAM")"
    exit "$1"
}

while getopts "h" OPT; do
    case "$OPT" in
        h) usage 0 ;;
        *) usage 1 ;;
    esac
done
shift $((OPTIND-1))

mkdir -p "$HOME/Downloads/Images/"
TMP_TEMPLATE="$HOME/Downloads/Images/XXXXXX"

TAB="$(printf '\t')"
A="$(printf '\a')"
rss-list.sh -u | tr "$TAB" "$A" | while IFS="$A" read -r FILE _ _ LINK DESC _; do
    case "$FILE" in
        *www.pixiv.net*)
            echo "$DESC" |
                grep -oE '<img src="[^"]*"' |
                cut -d'"' -f2 |
            while read -r IMG_LINK; do
                TMP="$(mktemp "$TMP_TEMPLATE")"
                curl "$IMG_LINK" > "$TMP"
                correct-ext.sh "$TMP"
            done || exit 1
            mv "$FILE" "$HOME/.cache/rss/read"
            ;;
        *tag:konachan.net*)
            TMP="$(mktemp "$TMP_TEMPLATE")"
            IMG_LINK="$(curl -s https://konachan.net/post/show/297793 |
                grep -o 'href="[^"]*" id="highres"' |
                cut -d'"' -f2)"
            curl "$IMG_LINK" > "$TMP" || exit 1
            correct-ext.sh "$TMP"
            mv "$FILE" "$HOME/.cache/rss/read"
            ;;
        *e-shuushuu.net*)
            TMP="$(mktemp "$TMP_TEMPLATE")"
            curl "$LINK" > "$TMP" || exit 1
            correct-ext.sh "$TMP"
            mv "$FILE" "$HOME/.cache/rss/read"
            ;;
        *) ;;
    esac
done
