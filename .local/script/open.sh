#!/bin/sh

program=${0##*/}
usage() {
    echo "Usage: $program"
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
arg1=$1
opener=$(opener.sh "$arg1")

for ARG in "$@"; do
    echo "$ARG" >> /tmp/open.log
    other=$(opener.sh "$ARG")
    if [ "$other" != "$opener" ]; then
        echo "Some args require different programs" >&2
        echo "> $opener $arg1" >&2
        echo "> $other $ARG" >&2
        exit 1
    fi
done

[ -z "$opener" ] && exit 1
$opener "$@"
