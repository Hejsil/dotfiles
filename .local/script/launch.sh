#!/bin/sh

setsid -f $(path_exes.sh | fzf --print-query | grep -v '^$' | tail -n 1)
