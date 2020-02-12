#!/bin/sh

VAL=$1
if [ -z "$VAL" ]; then
    echo 'No input' >&2
    exit 1
fi

while read -r UNIT; do
    if [ "$VAL" -lt 1024 ]; then
        echo "${VAL}${UNIT}"
        exit 0
    fi
    VAL=$(((VAL + 512) / 1024))
done << STRING
B
KiB
MiB
GiB
TiB
STRING

echo 'Number too big' >&2
exit 1

