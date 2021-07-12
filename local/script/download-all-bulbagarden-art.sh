#!/bin/sh

curl 'https://archives.bulbagarden.net/wiki/Category:Game_artwork' |
    rg '<a\s+href="/(wiki/Category:[^"]*)"' -o -r 'https://archives.bulbagarden.net/$1' |
    xargs -d '\n' curl |
    rg '<img\s+alt="[^"]*"\s+src="([^"]+)/thumb/([^"]+)/[^/"]*"' -o -r 'https:$1/$2' |
    xargs -d '\n' curl --remote-name-all
