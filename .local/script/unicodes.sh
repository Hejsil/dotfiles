#!/bin/sh

UNICODE="/tmp/unicode.txt"
[ -e "$UNICODE" ] || curl https://www.unicode.org/Public/UCD/latest/ucd/UnicodeData.txt >"$UNICODE"

while IFS=';' read -r CODE DESC REST; do echo '\u'"$CODE 0x$CODE $DESC"; done < "$UNICODE" \
    | ascii2uni -a U -q | rofi -dmenu -i | cut -d ' ' -f 1 | xclip -sel clip