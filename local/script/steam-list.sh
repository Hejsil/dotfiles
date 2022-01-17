#!/bin/sh
fd 'appmanifest_' "$HOME/.local/share/Steam/steamapps/" --maxdepth 1 |
    xargs rg --no-filename '^}|"appid"|"name"' |
    tr -d '\n' | tr '}' '\n' |
    exec rg -o '"appid"\s+"([^"]*)"\s+"name"\s+"([^"]*)"|"name"\s+"([^"]*)"\s+"appid"\s+"([^"]*)' -r "\$2\$3$(printf '\t')\$1\$4"
