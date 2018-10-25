#!/bin/sh
cd $(dirname $(readlink -f "$0")) || exit 1
mkdir "$HOME/.bin"
mkdir "$HOME/repo"

(
    cd "$(mktemp -d)" || exit 1
    sudo pacman -S --noconfirm go base-devel
    curl -o PKGBUILD https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=yay
    makepkg -i PKGBUILD --noconfirm
    rm -r "$(pwd)"
)

yay -S --noconfirm                    \
    gdm gnome gnome-tweaks            \
    visual-studio-code-bin            \
    chromium xclip                    \
    ttf-liberation                    \
    numix-frost-themes                \
    numix-icon-theme-pack-git         \
    zsh oh-my-zsh-git zsh-pure-prompt \
    zsh-fast-syntax-highlighting-git  \
    zsh-autosuggestions yay jq        \
    skim ripgrep fd hex lazygit

sudo systemctl enable gdm.service

chsh -s /usr/bin/zsh
./link-up.sh
