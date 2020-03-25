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

dir=$1
if [ -z "$dir" ]; then
    usage
    exit 1
fi

fd '' "$dir" -Ht f | rofi -dmenu
