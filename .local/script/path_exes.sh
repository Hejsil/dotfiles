#!/bin/sh
echo "$PATH" | tr ':' '\n' | xargs -I% find % -type f,l | xargs basename -a | sort -u

