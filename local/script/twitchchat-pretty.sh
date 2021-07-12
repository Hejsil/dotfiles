#!/bin/sh

clear
tput civis
trap 'tput cnorm' EXIT

TAB=$(printf '\t')
rg --line-buffered \
    '#\w+: \d{2}/\d{2}/\d{2} (\d{2}:\d{2}) <(\w+)> (.*)$' \
    -r "\$1$TAB\$2$TAB\$3" |
    while read -r clock name msg; do
        if [ "$last_name" = "$name" ]; then
            if [ "$last_clock" = "$clock" ]; then
                printf '\n   >> '
            else
                printf '\n%s ' "$clock"
            fi
        else
            name_hash=$(printf "%d" "0x$(printf '%s' "$name" | md5sum | nawk '{printf "%.8s", $1}')")
            name_color=$(printf '%s' "$name" | lolcat --force "--seed=$name_hash")
            printf '\n%s <%s>\n      ' "$clock" "$name_color"
        fi
        printf '%s' "$msg" | fmt -w "$(($(tput cols) - 6))" |
            sed '2,1000s/^/      /' |
            head -c -1
        last_name=$name
        last_clock=$clock
    done
