#!/bin/sh

id=$(steam-list.sh | fzf -d '\t' --with-nth=1 | tail -n 1 | cut -f2)
[ -z "$id" ] && exit 0

setsid -f steam "steam://run/$id"
