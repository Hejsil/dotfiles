#!/bin/sh

PROGRAM="$(basename "$0")"
usage() {
    echo "Usage: $(basename "$PROGRAM")"
}

while getopts "h" OPT; do
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

[ -z "$1" ] && exit 0
ARG1="$1"
OPENER="$(opener.sh "$ARG1")"

for ARG in "$@"; do
    echo "$ARG" >> /tmp/open.log
    OTHER="$(opener.sh "$ARG")"
    if [ "$OTHER" != "$OPENER" ]; then
        >&2 echo "Some args require different programs"
        >&2 echo "> $OPENER $ARG1"
        >&2 echo "> $OTHER $ARG"
        exit 1
    fi
done

[ -z "$OPENER" ] && exit 1
$OPENER "$@"
