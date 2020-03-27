#!/bin/sh

daemonize.sh $(path_exes.sh | fzf --print-query |
    grep -v '^$' | tail -n 1)
