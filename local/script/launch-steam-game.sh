#!/bin/sh

ids=$(steam-list.sh | fzf -m -d '\t' --with-nth=1 | cut -f2)
[ -z "$ids" ] && exit 0

action=$(printf 'run\nuninstall\n' | fzf | tail -n 1)
[ -z "$action" ] && exit 0
echo "$ids" | xargs -d'\n' -I% tsp steam "steam://$action/%"
