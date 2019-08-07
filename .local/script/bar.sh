#!/bin/sh

eval "$(grep 'color[0-9]*: #' "$HOME/.Xresources" | sed -E 's/^\*color([0-9]*): (.*)$/COLOR\1="\2"/')"

date_d() {
    while true; do
        echo "DATE='$(date '+%F %R')'"
        sleep 1
    done
}

usage() {
    grep -E 'cpu ' /proc/stat | sed -E "s/[ ]+/ /g" | cut -d ' ' -f 2,4,5
}

cpu_d() {
    LAST=$(mktemp /tmp/cpu-last.XXXXXX)
    CURR=$(mktemp /tmp/cpu-curr.XXXXXX)
    usage | sed 's/[0-9]*/0/g' > "$LAST"
    while true; do
        usage > "$CURR"
        echo "CPU='$(paste -d " " "$CURR" "$LAST" |\
            awk '{printf "%d %d %d\n",($1-$4),($2-$5),($3-$6)}' |\
            awk '{usage=($1+$2)/($1+$2+$3); printf "%d",usage*100}')'"
        cp "$CURR" "$LAST"
        sleep 2
    done
}

mem_d() {
    MEM_CURR=""
    MEM_MAX=""
    while true; do 
        MEM="$(cat /proc/meminfo | grep -E "Mem" | sed "s/[^0-9]//g" | tr '\n' ' ')"
        MEM_CURR2="$(echo "$MEM" | awk '{printf "%d",($1-$3)}')"
        MEM_MAX2="$(echo "$MEM" | awk '{printf "%d",$1}')"
        if [ "$MEM_CURR2" != "$MEM_CURR" ] || [ "$MEM_MAX2" != "$MEM_MAX" ]; then
            MEM_CURR="$MEM_CURR2"
            MEM_MAX="$MEM_MAX2"
            echo "MEM='$(echo "$MEM_CURR $MEM_MAX" | awk '{ printf "%d",($1/$2)*100}')'"
        fi
        sleep 2
    done
}

net_d() {
    NET_RECEIVED="0"
    NET_TRANSMITTED="0"
    while true; do
        NET=$(cat /proc/net/dev | tail -n +3 | sed -E 's/[ ]+/ /g' | cut -d ':' -f2 | cut -d ' ' -f 2,10)
        NET_RECEIVED2=$(echo "$NET" | cut -d ' ' -f1 | awk '{sum+=$1} END {print sum}')
        NET_TRANSMITTED2=$(echo "$NET" | cut -d ' ' -f2 | awk '{sum+=$1} END {print sum}')
        echo "NET_DOWN='$(expr $NET_RECEIVED2 - $NET_RECEIVED)'"
        echo "NET_UP='$(expr $NET_TRANSMITTED2 - $NET_TRANSMITTED)'"
        NET_RECEIVED="$NET_RECEIVED2"
        NET_TRANSMITTED="$NET_TRANSMITTED2"
        sleep 2
    done
}

volume_d() {
    while true; do
        echo "VOLUME='$(amixer sget Master | tr '\n' ' ' | cut -d "[" -f 2 | cut -d "%" -f 1)'"
        sleep 1 # TODO: wait for volume to change
    done
}

(
    date_d &
    cpu_d &
    mem_d &
    net_d &
    volume_d &
) | while read LINE; do
    echo "$LINE" >&2
    eval "$LINE"

    echo "\
%{l} \
%{U$COLOR1}%{+u} $(printf "up %7s" "$(bytes.sh "$NET_UP")") %{-u} \
%{U$COLOR2}%{+u} $(printf "down %7s" "$(bytes.sh "$NET_DOWN")") %{-u} \
%{U$COLOR3}%{+u} $(printf "cpu %3d" "$MEM")% %{-u} \
%{U$COLOR4}%{+u} $(printf "mem %3d" "$CPU")% %{-u} \
\
%{c}\
%{U$COLOR15}%{+u} $DATE %{-u}\
\
%{r}\
%{U$COLOR5}%{+u}▕$(echo "$VOLUME" | sab -l 10 -s ' ▏▎▍▌▋▊▉█')▏$(printf "%4s" "$VOLUME%") %{-u} \
"

done | lemonbar             \
    -f 'monospace:size=17'  \
    -B "$COLOR0"            \
    -F "$COLOR15"           \
    -u '3'
