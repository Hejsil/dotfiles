#!/bin/sh
SITE=$(dmenu -i -l 10 < ~/.data/sites)
[ -z "$SITE" ] || surf "$SITE"
