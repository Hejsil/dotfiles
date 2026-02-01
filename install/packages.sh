#!/bin/sh -e

< ~/.config/pkgs/arch xargs -d'\n' sudo pacman -S --noconfirm --needed
< ~/.config/pkgs/aur  xargs -d'\n' yay -S --noconfirm --needed
< ~/.config/pkgs/dipm xargs -d'\n' ~/.local/bin/dipm install
