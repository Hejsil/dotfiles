#!/bin/sh
sed -i \
         -e 's/#{{base00-hex}}/rgb(0%,0%,0%)/g' \
         -e 's/#{{base05-hex}}/rgb(100%,100%,100%)/g' \
    -e 's/#{{base00-hex}}/rgb(50%,0%,0%)/g' \
     -e 's/#{{base0A-hex}}/rgb(0%,50%,0%)/g' \
     -e 's/#{{base00-hex}}/rgb(50%,0%,50%)/g' \
     -e 's/#{{base05-hex}}/rgb(0%,0%,50%)/g' \
	"$@"
