#!/bin/sh

PROGRAM="${0##*/}"
usage() {
    echo "Usage: "
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

while true; do
    case $(date '+%u:%H:%M') in
        [1-4,7]:23:5*)
            notify-send -u 'critical' 'Go to sleep' 'Power off in 30m'
            sleep 30m
            poweroff
            ;;
        *) ;;
    esac

    sleep 30s
done
