#!/bin/sh

PROGRAM="$(basename "$0")"
usage() {
    echo "Usage: $(basename "$PROGRAM")"
    exit "$1"
}

while getopts "h" OPT; do
    case "$OPT" in
        h) usage 0 ;;
        *) usage 1 ;;
    esac
done
shift $((OPTIND-1))

wget -O /dev/null http://speedtest.wdc01.softlayer.com/downloads/test500.zip
