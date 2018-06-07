#!/bin/sh

SCRIPT=$(readlink -f "$0")
SCRIPTPATH=$(dirname "$SCRIPT")

mkdir build
cd build
sudo pacman -S go
curl -o PKGBUILD https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=yay
makepkg -i PKGBUILD --noconfirm
cd ..
rm -r build

yay -S yay
yay -S zsh
yay -S oh-my-zsh-git
yay -S zsh-pure-prompt
yay -S zsh-fast-syntax-highlighting-git
yay -S zsh-autosuggestions

chsh -s /usr/bin/zsh

"$SCRIPTPATH/link-up.sh"
