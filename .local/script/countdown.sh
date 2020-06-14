time="$1"
msg="$2"

seq "$time" -1 0 |
    awk '{printf "%.2d:%.2d\n", $1/60, $1%60}' |
while read -r fmt_time; do
    { clear; printf '\n\n\n\n\n\n\n\n\n\n\n\n\n'; figlet -ctp "$msg"; figlet -ctp "$fmt_time"; } | sponge
    sleep 1s
done

