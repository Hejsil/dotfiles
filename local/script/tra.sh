#!/bin/sh
transmission-remote 192.168.0.119 -a "$1" || exit 1
exec notify-send 'Torrent added' "$1"
