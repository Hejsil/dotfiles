#!/bin/sh

old_ratio=$(bspc config split_ratio)
bspc config split_ratio 0.78
kitty &
kitty &
bspc subscribe -c 2 node_add
bspc config split_ratio 0.70

kitty &
bspc subscribe -c 1 node_add
bspc config split_ratio "$old_ratio"
