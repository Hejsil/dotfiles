#!/bin/sh -e

cd "$(dirname "$0")" || exit 1

install/linkup.sh
install/home-dirs.sh
install/programs.sh
install/packages.sh
install/services.sh

sudo usermod -aG docker "$USER"
sudo usermod -aG games "$USER"
sudo usermod -aG input "$USER"

echo '# https://wiki.hyprland.org/Configuring/Monitors/' >"$HOME/.config/hypr/monitor.conf"
touch "$HOME/.config/hypr/workspace.conf"
