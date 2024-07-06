#!/bin/sh -e

cd "$(dirname "$0")" || exit 1

install/linkup.sh
install/home-dirs.sh
install/system-files.sh
install/programs.sh
install/services.sh

local/script/generate

echo '# https://wiki.hyprland.org/Configuring/Monitors/' >"$HOME/.config/hypr/monitor.conf"
touch "$HOME/.config/hypr/workspace.conf"
