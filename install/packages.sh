#!/bin/sh -e

<"$HOME/.config/pkgs/arch" xargs -d'\n' sudo pacman -S --noconfirm --needed
<"$HOME/.config/pkgs/aur" xargs -d'\n' yay -S --noconfirm --needed
<"$HOME/.config/pkgs/dipm" xargs -d'\n' dipm install
