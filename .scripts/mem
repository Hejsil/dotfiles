#!/bin/sh
cat /proc/meminfo | grep -E "Mem" | sed "s/[^0-9]//g" | tr '\n' ' '| awk '{printf "%d %d\n",($1-$3),$1}'
