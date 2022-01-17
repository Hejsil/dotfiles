#!/bin/sh
path-exes.sh | fzf -m | exec xargs -d'\n' -n 1 tsp
