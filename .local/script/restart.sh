#!/bin/sh
STDIN=$(if [ -t 0 ]; then echo ''; else cat; fi)

DIR='/tmp/processes'
LOG_DIR='/tmp/logs'
FILE="$DIR/$(echo "$@" | sed 's#/#|#g')"
LOG_FILE="$LOG_DIR/$(echo "$@" | sed 's#/#|#g')"
mkdir -p "$DIR" "$LOG_DIR"
[ -s "$FILE" ] && kill -- "-$(cat "$FILE")"

echo "$STDIN" | nohup "$@" 2>"$LOG_FILE" >"$LOG_FILE" &
ps -o pgid= "$!" >"$FILE"
