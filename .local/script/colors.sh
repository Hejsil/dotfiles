#!/bin/sh
seq 0 15 | xargs -I{} printf "COLOR%d='#{{base0%X-hex}}'\n" {} {} | base16.sh "$HOME/colors.yaml"
