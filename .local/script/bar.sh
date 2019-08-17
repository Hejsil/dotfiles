#!/bin/sh

CPU_LAST="$(mktemp /tmp/cpu-last.XXXXXX)"
CPU_CURR="$(mktemp /tmp/cpu-curr.XXXXXX)"
MEM_CURR=''
MEM_MAX=''
NET_RECEIVED='0'
NET_TRANSMITTED='0'

# Load theme from .Xresources
eval "$(grep 'color[0-9]*:[ ]*#' "$HOME/.Xresources" | sed -E 's/^\*color([0-9]*):[ ]*(.*)$/COLOR\1="\2"/')"

cpu_usage() {
    grep -E 'cpu ' /proc/stat | sed -E "s/[ ]+/ /g" | cut -d ' ' -f 2,4,5
}

cpu_usage | sed 's/[0-9]*/0/g' >"$CPU_LAST"

(
    seq 0 inf | while read -r I; do
        printf "%s" "DATE='$(date '+%F %R')';"
        printf "%s" "VOLUME='$(amixer sget Master | tr '\n' ' ' | cut -d "[" -f 2 | cut -d "%" -f 1)';"
    
        if [ $((I % 2)) = 0 ]; then
            printf "%s" "NEWS='$(newsboat -x print-unread | cut -d ' ' -f1)';"
    
            NET=$(tail -n +3 /proc/net/dev | sed -E 's/[ ]+/ /g' | cut -d ':' -f2 | cut -d ' ' -f 2,10)
            NET_RECEIVED2=$(echo "$NET" | cut -d ' ' -f1 | awk '{sum+=$1} END {print sum}')
            NET_TRANSMITTED2=$(echo "$NET" | cut -d ' ' -f2 | awk '{sum+=$1} END {print sum}')
            printf "%s" "NET_DOWN='$((NET_RECEIVED2 - NET_RECEIVED))';"
            printf "%s" "NET_UP='$((NET_TRANSMITTED2 - NET_TRANSMITTED))';"
            NET_RECEIVED="$NET_RECEIVED2"
            NET_TRANSMITTED="$NET_TRANSMITTED2"
    
            MEMORY="$(grep -E "Mem" /proc/meminfo | sed "s/[^0-9]//g" | tr '\n' ' ')"
            MEM_CURR2="$(echo "$MEMORY" | awk '{printf "%d",($1-$3)}')"
            MEM_MAX2="$(echo "$MEMORY" | awk '{printf "%d",$1}')"
            if [ "$MEM_CURR2" != "$MEM_CURR" ] || [ "$MEM_MAX2" != "$MEM_MAX" ]; then
                MEM_CURR="$MEM_CURR2"
                MEM_MAX="$MEM_MAX2"
                printf "%s" "MEM='$(echo "$MEM_CURR $MEM_MAX" | awk '{ printf "%d",($1/$2)*100}')';"
            fi
    
            cpu_usage >"$CPU_CURR"
            printf "%s" "CPU='$(paste -d " " "$CPU_CURR" "$CPU_LAST" |
                awk '{printf "%d %d %d\n",($1-$4),($2-$5),($3-$6)}' |
                awk '{usage=($1+$2)/($1+$2+$3); printf "%d",usage*100}')';"
            cp "$CPU_CURR" "$CPU_LAST"
        fi
    
        # refresh newsboat every hour
        if [ $((I % 60 * 60)) = 0 ]; then
            newsboat -x reload >/dev/null &
        fi
    
        echo ""
        sleep 1
    done &

) | while read -r LINE; do
    echo "$LINE" >&2
    eval "$LINE"

    for MONITOR in $(bspc query -M --names | nl -w1 -v0 | cut -f1); do
        printf "%s" "%{S$MONITOR}%{l}"
        printf "%s" " %{U$COLOR1}%{$COLOR1}%{+o} $(printf "up %7s" "$(bytes.sh "$NET_UP")") %{-o}"
        printf "%s" " %{U$COLOR2}%{+o} $(printf "down %7s" "$(bytes.sh "$NET_DOWN")") %{-o}"
        printf "%s" " %{U$COLOR3}%{+o} $(printf "cpu %3d" "$CPU")% %{-o} "
        printf "%s" " %{U$COLOR4}%{+o} $(printf "mem %3d" "$MEM")% %{-o}"

        printf "%s" "%{c}"
        printf "%s" "%{U$COLOR15}%{+o} $DATE %{-o}"

        printf "%s" "%{r}"
        printf "%s" "%{U$COLOR5}%{+o} $(printf "news %2d" "$NEWS") %{-o} "
        printf "%s" "%{U$COLOR6}%{+o} $(echo "$VOLUME" | sab -l 10 -s ' ▏▎▍▌▋▊▉█') $(printf "%4s" "$VOLUME%") %{-o} "
    done
    echo ""
done | lemonbar             \
    -f 'monospace:size=17'  \
    -B "$COLOR0"            \
    -F "$COLOR15"           \
    -u '2'                  \
    -o '1'
