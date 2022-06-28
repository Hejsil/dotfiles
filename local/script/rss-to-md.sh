#!/bin/sh

tail -n +2 "$1" | head -n 1

echo
tail -n +3 "$1" |
    sd -p '\\n' "\n" |
    bat -l md --style plain --color always --wrap character --terminal-width "$FZF_PREVIEW_COLUMNS"
