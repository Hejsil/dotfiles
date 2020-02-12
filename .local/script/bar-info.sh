#!/bin/sh

set -e

print_volume() {
    amixer sget Master | tr '\n' ' ' | cut -d'[' -f2 | cut -d'%' -f 1
}

print_news() {
    find "$HOME/.cache/rss/unread/" -type f | wc -l
}

print_mem() {
    MEMORY="$(grep 'Mem' /proc/meminfo | sed "s/[^0-9]*//g" | tr '\n' ' ')"
    MEM_CURR2=$(echo "$MEMORY" | awk '{ printf "%d", ($1-$3) }')
    MEM_MAX2=$(echo "$MEMORY" | awk '{ printf "%d", $1 }')
    if [ "$MEM_CURR2" != "$MEM_CURR" ] || [ "$MEM_MAX2" != "$MEM_MAX" ]; then
        MEM_CURR=$MEM_CURR2
        MEM_MAX=$MEM_MAX2
        echo "$MEM_CURR $MEM_MAX" | awk '{ printf "%d", ($1/$2)*100 }'
    fi
}

cpu_usage() {
    grep 'cpu ' /proc/stat | awk '{ print $2, $4, $5 }'
}

CPU_LAST=$(mktemp /tmp/cpu-last.XXXXXX)
CPU_CURR=$(mktemp /tmp/cpu-curr.XXXXXX)
cpu_usage | sed 's/[0-9]*/0/g' >"$CPU_LAST"
print_cpu() {
    cpu_usage >"$CPU_CURR"
    paste -d' ' "$CPU_CURR" "$CPU_LAST" |
        awk '{ printf "%d %d %d\n", ($1-$4), ($2-$5), ($3-$6) }' |
        awk '{ usage=($1+$2)/($1+$2+$3); printf "%d", usage*100 }'
    cp "$CPU_CURR" "$CPU_LAST"
}

var_wrap() {
    sed -u "s/'/'\"'\"'/g" | sed -u -E "s/(.*)/$1='\1';/"
}

{
    touch /tmp/volume-notify-file
    print_volume

    while inotifywait /tmp/volume-notify-file 2>/dev/null >/dev/null; do
        print_volume
    done
} | var_wrap 'VOLUME' &

bspc subscribe report | var_wrap 'BSPWM_REPORT' &
xtitle -s | var_wrap 'WINDOW' &

seq 0 inf | while read -r I; do
    {
        # Things to run every second
        date '+%R' | var_wrap 'TIME'

        # Things to run every 2 seconds
        if [ $((I % 2)) = 0 ]; then
            print_mem | var_wrap 'MEM'
            print_cpu | var_wrap 'CPU'
        fi
        # Things to run every 4 seconds
        if [ $((I % 4)) = 0 ]; then
            date '+%F' | var_wrap 'DATE'
            print_news | var_wrap 'NEWS'
        fi
    } | tr '\n' ' '
    echo ""

    sleep 1
done
