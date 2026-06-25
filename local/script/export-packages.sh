#!/bin/sh -e
# Export currently installed packages back to dotfiles
# This allows for imperative package management with periodic syncing to git

type -q pacman && pacman -Qq > "$HOME/.config/pkgs/arch"
type -q yay && yay -Qq --foreign > "$HOME/.config/pkgs/aur"
type -q dipm && dipm list > "$HOME/.config/pkgs/dipm"
