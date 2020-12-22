#!/bin/sh

setsid -f $(path-exes.sh | fzf --print-query | grep -v '^$' | tail -n 1)
sleep 0.05s
