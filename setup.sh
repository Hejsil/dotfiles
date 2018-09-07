#!/bin/sh

SCRIPT=$(readlink -f "$0")
SCRIPTPATH=$(dirname "$SCRIPT")

(
    cd "$(mktemp -d)" || exit 1
    sudo pacman -S --noconfirm go
    curl -o PKGBUILD https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=yay
    makepkg -i PKGBUILD --noconfirm
    rm -r "$(pwd)"
)

yay -S --noconfirm yay

# zsh stuff
yay -S --noconfirm zsh
yay -S --noconfirm oh-my-zsh-git
yay -S --noconfirm zsh-pure-prompt
yay -S --noconfirm zsh-fast-syntax-highlighting-git
yay -S --noconfirm zsh-autosuggestions

# Term tools
yay -S --noconfirm gnu-netcat
yay -S --noconfirm skim
yay -S --noconfirm ripgrep
yay -S --noconfirm fd
yay -S --noconfirm hex
yay -S --noconfirm lazygit

chsh -s /usr/bin/zsh

"$SCRIPTPATH/link-up.sh"
