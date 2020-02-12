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

wget -O /dev/null 'http://speedtest.wdc01.softlayer.com/downloads/test500.zip'
