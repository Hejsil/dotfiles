#!/bin/sh

old_ratio=$(bspc config split_ratio)
bspc config split_ratio 0.78
$TERMINAL &
$TERMINAL -e dash -c 'tail -f -n 40 | twitchchat-pretty.sh' &
bspc subscribe -c 2 node_add
bspc config split_ratio 0.70

$TERMINAL &
bspc subscribe -c 1 node_add
exec bspc config split_ratio "$old_ratio"
