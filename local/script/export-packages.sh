#!/bin/sh -e
# Export currently installed packages back to dotfiles
# This allows for imperative package management with periodic syncing to git

command -v pacman >/dev/null &&
  pacman -Qq >"$HOME/.config/pkgs/arch"

command -v yay >/dev/null &&
  yay -Qq --foreign >"$HOME/.config/pkgs/aur"

command -v dipm >/dev/null &&
  dipm list installed >"$HOME/.config/pkgs/dipm"
