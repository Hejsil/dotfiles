#!/bin/sh
stdin=$(if [ -t 0 ]; then echo ''; else cat; fi)

dir='/tmp/processes'
log_dir='/tmp/logs'
file="$dir/$(echo "$@" | sed 's#/#|#g')"
log_file="$log_dir/$(echo "$@" | sed 's#/#|#g')"
mkdir -p "$dir" "$log_dir"
[ -s "$file" ] && kill -- "-$(cat "$file")"

echo "$stdin" | nohup "$@" 2>"$log_file" >"$log_file" &
ps -o pgid= "$!" >"$file"
