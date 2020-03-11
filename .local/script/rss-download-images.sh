#!/bin/sh

PROGRAM=${0##*/}
usage() {
    echo "Usage: $PROGRAM"
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

mkdir -p "$HOME/Downloads/Images/"
TMP_TEMPLATE=$HOME/Downloads/Images/XXXXXX

TAB=$(printf '\t')
A=$(printf '\a')
rss-list.sh -u | tr "$TAB" "$A" | while IFS=$A read -r FILE _ _ LINK DESC _; do
    case $FILE in
        *tag:konachan.*)
            curl -s "$LINK" |
                grep -o 'href="[^"]*" id="highres"' |
                cut -d'"' -f2 |
                sed "s$TAB^$TAB$FILE$A$TAB"
            ;;
        *e-shuushuu.net*)
            echo "$FILE$A$LINK"
            ;;
        *www.pixiv.net*|*www.artstation.com*)
            echo "$DESC" | grep -oE '\w+:\/\/[-a-zA-Z0-9:@;?&=\/%\+\.\*!'"'"'\(\),\$_\{\}\^~`#|]+' |
                sed "s$TAB^$TAB$FILE$A$TAB"
            ;;
        *) case $LINK in
                *www.reddit.com*)
                    echo "$DESC" | grep -oE '\w+:\/\/[-a-zA-Z0-9:@;?&=\/%\+\.\*!'"'"'\(\),\$_\{\}\^~`#|]+' |
                        sed "s$TAB^$TAB$FILE$A$TAB"
                    ;;
                *) ;;
            esac
            ;;
    esac
done | while IFS=$A read -r FILE LINK; do
    TMP=$(mktemp "$TMP_TEMPLATE")
    curl "$LINK" > "$TMP" || continue
    case $(file -b --mime-type "$TMP") in
        image/*)
            correct-ext.sh "$TMP"
            mv "$FILE" "$HOME/.cache/rss/read"
            ;;
        *)
            rm "$TMP"
            ;;
    esac
done




