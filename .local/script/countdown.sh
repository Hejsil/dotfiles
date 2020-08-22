time="$1"
msg="$2"
music="$3"
volume="$4"

now_playing='Now playing:'
music_name=$(youtube-dl -J "$music" | jq -r '"\(.title) - \(.uploader) "')

msg_len=$(echo "$msg" | wc -c)
time_len=$(echo "00:00" | wc -c)
now_playing_len=$(echo "$now_playing" | wc -c)
music_len=$(echo "$music_name" | wc -c)

clear

mpv -vid=no --volume=$volume --no-terminal "$music" &
trap 'killall mpv' EXIT

tput civis
trap 'tput cnorm' EXIT

cols=$(tput cols)
tput cup 1 $(( (cols - msg_len) / 2 + 1 )) 
printf %s "$msg"

tput cup 4 $(( (cols - now_playing_len) / 2 + 1 ))
printf "$now_playing"
tput cup 5 $(( (cols - music_len) / 2 + 1 ))
printf "$music_name"

seq "$time" -1 0 |
    awk '{printf "%.2d:%.2d\n", $1/60, $1%60}' |
while read -r fmt_time; do
    tput cup 2 $(( (cols - time_len) / 2 + 1 ))
    printf "$fmt_time"
    sleep 1s
done

read _

