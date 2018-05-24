#!/bin/sh

SCRIPT=$(readlink -f "$0")
SCRIPTPATH=$(dirname "$SCRIPT")

sudo pacman -S pacaur
pacaur -S zsh
pacaur -S oh-my-zsh-git
pacaur -S zsh-pure-prompt
pacaur -S zsh-fast-syntax-highlighting-git
pacaur -S zsh-autosuggestions

chsh -s /usr/bin/zsh

"$SCRIPTPATH/link-up.sh"
