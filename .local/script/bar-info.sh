#!/usr/bin/env -S sh -e

print_volume() {
    pulsemixer --get-volume | cut -f1 -d' '
}

print_mails() {
    fd ',$' "$HOME/.local/share/mail/" --type f | wc -l
}

print_rss() {
    fd '.' "$HOME/.cache/rss/unread/" --type f | wc -l
}

wrap() { sed -u "s/^/$1=/"; }
uniq2() { stdbuf -o L uniq; }

{
    print_volume

    pactl subscribe | rg --line-buffered 'on sink' | while read -r _; do
        print_volume
    done
} | uniq2 | wrap 'vol' &

{
    print_mails
    while inotifywait "$HOME/.local/share/mail/" -r -e 'move,create,delete' 2>/dev/null >/dev/null; do
        print_mails
    done
} | uniq2 | wrap 'mail' &

{
    print_rss
    while inotifywait "$HOME/.cache/rss/unread" -r -e 'move,create,delete' 2>/dev/null >/dev/null; do
        print_rss
    done
} | uniq2 | wrap 'rss' &


{
    # Wait for bspc to be available. This allows us to run
    # the bar before bspwm has been run
    while ! bspc subscribe -c 1; do sleep 0.1s; done
    bspc subscribe report
} | uniq2 | wrap 'bspwm' &

xtitle -s | uniq2 | wrap 'win' &

# Print the date every second
while true; do
    # Do 10 minutes, then repeat. This is to handle things like system suspends
    d=$(date +%s)
    seq "$d" 1 "$((d + 60 * 10))" | sed 's/^/@/' | date -f - '+%b %d %a %R' |
        delay-line 1s
done | uniq2 | wrap 'date' &

# Print cpu usage every second
cpu_count=$(grep -c processor /proc/cpuinfo)
mpstat -P ALL 1 |
    # Filter out lines that doesn't contain information
    sed -u -e '/^$/d' -e '/all/d' -e '/CPU/d' | choose -1 |
    # Pick idle percentage and make it into usage percentage
    stdbuf -o L nawk '{printf "%d\n", 100-$1}' |
    # Group N lines into one line where N is the number of CPUs
    # we have on the systel.
    stdbuf -o L paste -d ' ' $(yes - | head -n "$cpu_count" | tr '\n' ' ') |
    uniq2 |
    wrap 'cpu' &

# Print memory usage every second
free -s 1 |
    # Filter out unused information
    grep --line-buffered Mem | choose 1 2 |
    # Calculate memory usage in percent
    stdbuf -o L nawk '{ printf "%d\n", ($2/$1)*100 }' |
    uniq2 |
    wrap 'mem' &


