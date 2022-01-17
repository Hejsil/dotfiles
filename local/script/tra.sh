#!/bin/sh
transmission-remote -a "$1" || exit 1
exec notify-send 'Torrent added' "$1"
