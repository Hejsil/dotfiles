#!/bin/sh


dash='https://dashboard.twitch.tv/popout/u/komarispaghetti/stream-manager'
class='Chromium'
dash_class_prefix='dashboard.twitch.tv'
dashpop_class_prefix="${dash_class_prefix}__popout_u_komarispaghetti_stream-manager"

bspc node -i
bspc node @/ -p east -o 0.45 -i
bspc node @/2 -p east -o 0.45 -i
bspc node @/2/2 -p south -o 0.5 -i

bspc node @/2/2/1 -o 0.5 -p east -i
bspc node @/2/2/2 -o 0.5 -p east -i

# left
bspc rule -a 'Tor Browser:Navigator' -o node=@/1
bspc rule -a "${class}:${dash_class_prefix}__u_komarispaghetti_stream-manager" -o node=@/2/1

bspc rule -a "${class}:${dashpop_class_prefix}_activity-feed" -o node=@/2/2/1/1
bspc rule -a "${class}:${dashpop_class_prefix}_reward-queue" -o node=@/2/2/1/2

bspc rule -a "${class}:${dashpop_class_prefix}_quick-actions" -o node=@/2/2/2/1
bspc rule -a "${class}:${dashpop_class_prefix}_edit-stream-info" -o node=@/2/2/2/2


chromium "--app=https://dashboard.twitch.tv/u/komarispaghetti/stream-manager" &
chromium "--app=$dash/quick-actions" &
chromium "--app=$dash/activity-feed" &
chromium "--app=$dash/edit-stream-info" &
chromium "--app=$dash/reward-queue" &
tor-browser --allow-remote &

wait

