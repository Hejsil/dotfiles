#!/bin/sh

print_date() {
    printf "DATE='%s';" "$(date '+%F %R')"
}

print_volume() {
    printf "VOLUME='%s';" "$(amixer sget Master | tr '\n' ' ' | cut -d "[" -f 2 | cut -d "%" -f 1)"
}

print_news() {
    printf "NEWS='%s';" "$(newsboat -x print-unread | cut -d ' ' -f1)"
}

NET_RECEIVED='0'
NET_TRANSMITTED='0'
print_net() {
    NET=$(tail -n +3 /proc/net/dev | sed -E 's/[ ]+/ /g' | cut -d ':' -f2 | cut -d ' ' -f 2,10)
    NET_RECEIVED2=$(echo "$NET" | cut -d ' ' -f1 | awk '{sum+=$1} END {print sum}')
    NET_TRANSMITTED2=$(echo "$NET" | cut -d ' ' -f2 | awk '{sum+=$1} END {print sum}')
    printf "NET_DOWN='%s';" "$((NET_RECEIVED2 - NET_RECEIVED))"
    printf "NET_UP='%s';" "$((NET_TRANSMITTED2 - NET_TRANSMITTED))"
    NET_RECEIVED="$NET_RECEIVED2"
    NET_TRANSMITTED="$NET_TRANSMITTED2"
}

print_mem() {
    MEMORY="$(grep -E "Mem" /proc/meminfo | sed "s/[^0-9]//g" | tr '\n' ' ')"
    MEM_CURR2="$(echo "$MEMORY" | awk '{printf "%d",($1-$3)}')"
    MEM_MAX2="$(echo "$MEMORY" | awk '{printf "%d",$1}')"
    if [ "$MEM_CURR2" != "$MEM_CURR" ] || [ "$MEM_MAX2" != "$MEM_MAX" ]; then
        MEM_CURR="$MEM_CURR2"
        MEM_MAX="$MEM_MAX2"
        printf "MEM='%s';" "$(echo "$MEM_CURR $MEM_MAX" | awk '{ printf "%d",($1/$2)*100}')"
    fi
}

cpu_usage() {
    grep -E 'cpu ' /proc/stat | sed -E "s/[ ]+/ /g" | cut -d ' ' -f 2,4,5
}

CPU_LAST="$(mktemp /tmp/cpu-last.XXXXXX)"
CPU_CURR="$(mktemp /tmp/cpu-curr.XXXXXX)"
cpu_usage | sed 's/[0-9]*/0/g' >"$CPU_LAST"
print_cpu() {
    cpu_usage >"$CPU_CURR"
    printf "CPU='%s';" "$(paste -d " " "$CPU_CURR" "$CPU_LAST" |
        awk '{printf "%d %d %d\n",($1-$4),($2-$5),($3-$6)}' |
        awk '{usage=($1+$2)/($1+$2+$3); printf "%d",usage*100}')"
    cp "$CPU_CURR" "$CPU_LAST"
}

seq 0 inf | while read -r I; do
    # Things to run every second
    print_date
    print_volume

    # Things to run every 2 seconds
    if [ $((I % 2)) = 0 ]; then
        print_news
        print_net
        print_mem
        print_cpu
    fi

    # refresh newsboat every hour
    if [ $((I % 60 * 60)) = 0 ]; then
        newsboat -x reload >/dev/null &
    fi

    echo ""
    sleep 1
done
