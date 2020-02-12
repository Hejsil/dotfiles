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

[ -z "$1" ] && exit 0
ARG1=$1
OPENER=$(opener.sh "$ARG1")

for ARG in "$@"; do
    echo "$ARG" >> /tmp/open.log
    OTHER=$(opener.sh "$ARG")
    if [ "$OTHER" != "$OPENER" ]; then
        echo "Some args require different programs" >&2
        echo "> $OPENER $ARG1" >&2
        echo "> $OTHER $ARG" >&2
        exit 1
    fi
done

[ -z "$OPENER" ] && exit 1
$OPENER "$@"
