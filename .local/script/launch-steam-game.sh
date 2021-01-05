#!/bin/sh

id=$(steam-list.sh | fzf -d '\t' --with-nth=1 | tail -n 1 | cut -f2)
[ -z "$id" ] && exit 0

action=$(printf 'run\nuninstall\n' | fzf | tail -n 1)
[ -z "$action" ] && exit 0
tsp steam "steam://$action/$id"
