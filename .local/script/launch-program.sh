#!/bin/sh
path-exes.sh | fzf -m | xargs -d'\n' -n 1 tsp
