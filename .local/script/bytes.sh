#!/bin/sh

value=$1
if [ -z "$value" ]; then
    echo 'No input' >&2
    exit 1
fi

while read -r UNIT; do
    if [ "$value" -lt 1024 ]; then
        echo "${value}${UNIT}"
        exit 0
    fi
    value=$(((value + 512) / 1024))
done << STRING
B
KiB
MiB
GiB
TiB
STRING

echo 'Number too big' >&2
exit 1

