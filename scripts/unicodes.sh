#!/bin/sh
wget -O - https://www.unicode.org/Public/UCD/latest/ucd/UnicodeData.txt | \
    while IFS=';' read -r CODE DESC REST; do echo '\u'"$CODE 0x$CODE $DESC"; done \
    | ascii2uni -a U -q | rofi -dmenu -i | cut -d ' ' -f 1 | xclip -sel clip