#!/bin/sh -e
# Export currently installed packages back to dotfiles
# This allows for imperative package management with periodic syncing to git

pacman -Qq > "$HOME/.config/pkgs/arch"
yay -Qq --foreign > "$HOME/.config/pkgs/aur"
~/.local/bin/dipm list > "$HOME/.config/pkgs/dipm"
