#!/bin/sh -e

print_volume() {
    pulsemixer --get-volume | cut -f1 -d' '
}

print_mails() {
    find "$HOME/.local/share/mail/" -type f | grep -c ',$'
}

print_rss() {
    find "$HOME/.cache/rss/unread/" -type f | wc -l
}

print_mem() {
    MEMORY="$(grep 'Mem' /proc/meminfo | sed "s/[^0-9]*//g" | tr '\n' ' ')"
    MEM_CURR=$(echo "$MEMORY" | awk '{ printf "%d", ($1-$3) }')
    MEM_MAX=$(echo "$MEMORY" | awk '{ printf "%d", $1 }')
    echo "$MEM_CURR $MEM_MAX" | awk '{ printf "%d\n", ($1/$2)*100 }'
}

cpu_usage() {
    grep 'cpu[0-9]' /proc/stat | awk '{ print $2, $4, $5 }'
}

cpu_last=$(mktemp /tmp/cpu-last.XXXXXX)
cpu_curr=$(mktemp /tmp/cpu-curr.XXXXXX)
cpu_usage | sed 's/[0-9]*/0/g' >"$cpu_last"
print_cpu() {
    cpu_usage >"$cpu_curr"
    paste -d' ' "$cpu_curr" "$cpu_last" |
        awk '{ printf "%d %d %d\n", ($1-$4), ($2-$5), ($3-$6) }' |
        awk '{ usage=($1+$2)/($1+$2+$3); printf "%d ", usage*100 }'
    echo

    cp "$cpu_curr" "$cpu_last"
}

wrap() {
    sed -u "s/^/$1=/"
}

{
    touch /tmp/volume-notify-file
    print_volume

    while inotifywait /tmp/volume-notify-file 2>/dev/null >/dev/null; do
        print_volume
    done
} | wrap 'vol' &

{
    print_mails
    while inotifywait "$HOME/.local/share/mail/" -r -e 'move,create,delete' 2>/dev/null >/dev/null; do
        print_mails
    done
} | wrap 'mail' & 

{
    print_rss
    while inotifywait "$HOME/.cache/rss/unread" -r -e 'move,create,delete' 2>/dev/null >/dev/null; do
        print_rss
    done
} | wrap 'rss' & 


{
    # Wait for bspc to be awailable. This allows us to run
    # the bar before bspwm has been run
    while ! bspc subscribe -c 1; do :; done
    bspc subscribe report | wrap 'bspwm'
} &

xtitle -s | wrap 'win' &

seq 0 inf | while read -r I; do
    # Things to run every second
    date '+%b %d %a %R' | wrap 'date'

    # Things to run every 2 seconds
    if [ $((I % 2)) = 0 ]; then
        print_mem | wrap 'mem'
        print_cpu | wrap 'cpu'
    fi
    sleep 1
done
