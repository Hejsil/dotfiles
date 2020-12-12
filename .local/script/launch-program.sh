#!/usr/bin/sh

setsid -f $(path-exes.sh | fzf --print-query | grep -v '^$' | tail -n 1)
