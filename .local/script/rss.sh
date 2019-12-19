#!/bin/sh

PROGRAM="$(basename "$0")"
usage() {
    echo "Usage: $PROGRAM [-h]"
    echo "    -h    Print hel information and exists"
}

while getopts "i:h" OPT; do
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

dir_with_fallback() {
    DIR="$1"
    FALLBACK="$2"
    if [ -e "$DIR" ]; then
        echo "$DIR"
    else
        echo "$FALLBACK"
    fi
}

GLOBAL_CACHE_DIR="$(dir_with_fallback "$XDG_CACHE_HOME" "$HOME/.cache")"
GLOBAL_CONFIG_DIR="$(dir_with_fallback "$XDG_CONFIG_HOME" "$HOME/.config")"

# cache dirs
CACHE_DIR="$GLOBAL_CACHE_DIR/rss";
UNREAD_DIR="$CACHE_DIR/unread"; mkdir -p "$UNREAD_DIR"
READ_DIR="$CACHE_DIR/read"; mkdir -p "$READ_DIR"

# configs
CONFIG_DIR="$GLOBAL_CONFIG_DIR/rss"; mkdir -p "$CONFIG_DIR"
URL_CONFIG="$CONFIG_DIR/urls"; touch -a "$URL_CONFIG"

while read -r LINE; do
    curl -s "$LINE" | sfeed | tr '\t' '\a'
done < "$URL_CONFIG" |
while IFS="$(printf '\a')" read -r TIMESTAMP TITLE LINK CONTENT CONTENT_TYPE ID AUTHOR ENCLOSURE; do
    ID="$(echo "$ID" | sed 's#/#|#g')"
    [ -z "$ID" ] && ID="$(echo "$LINK" | sed 's#/#|#g')"
    [ -z "$ID" ] && {
        >&2 echo 'No id'
        continue
    }
    [ -e "$UNREAD_DIR/$ID" ] && continue
    [ -e "$READ_DIR/$ID" ] && continue

    printf "%s\n%s\n%s\n%s\n%s\n%s\n%s\n" "$TIMESTAMP" "$TITLE" "$LINK" \
        "$CONTENT" "$CONTENT_TYPE" "$AUTHOR" "$ENCLOSURE" \
        >"$UNREAD_DIR/$ID"
done
