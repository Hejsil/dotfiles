#!/bin/sh
sed -i \
         -e 's/rgb(0%,0%,0%)/#{{base00-hex}}/g' \
         -e 's/rgb(100%,100%,100%)/#{{base05-hex}}/g' \
    -e 's/rgb(50%,0%,0%)/#{{base00-hex}}/g' \
     -e 's/rgb(0%,50%,0%)/#{{base0A-hex}}/g' \
 -e 's/rgb(0%,50.196078%,0%)/#{{base0A-hex}}/g' \
     -e 's/rgb(50%,0%,50%)/#{{base00-hex}}/g' \
 -e 's/rgb(50.196078%,0%,50.196078%)/#{{base00-hex}}/g' \
     -e 's/rgb(0%,0%,50%)/#{{base05-hex}}/g' \
	"$@"
