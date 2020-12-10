#!/usr/bin/env -S sh
transmission-remote -a "$1" || exit 1
notify-send 'Torrent added' "$1"
