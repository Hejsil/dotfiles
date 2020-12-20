#!/bin/sh

mkdir -p '/tmp/twitch'
touch '/tmp/twitch/komarispaghetti'

st -e twitchbot.sh -c 'komarispaghetti' -n 'komarispaghetti' \
    -a "$(pass show twitch-oath)" &

st -e twitchbot-open-links.sh komarispaghetti 'tor-browser --allow-remote' \
    /tmp/twitch &

# st -e twitchbot-tm35-instance.sh komarispaghetti /tmp/twitch \
#     "$HOME/repo/metronome/zig-cache/bin" \
#     "$HOME/repo/melonDS/build/melonDS" \
#     "$HOME/mega/documents/roms/pokemon/gen5/pokemon_black2_ireo.nds" \
#     "$HOME/repo/metronome/black2-twitch-mods.nds" &

st -e tail -f '/tmp/twitch/komarispaghetti' &

wait

