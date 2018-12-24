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

yay -S --noconfirm                     \
    gdm openbox thunderbird nitrogen   \
    visual-studio-code-bin deluge      \
    python2-gobject2 pygtk sakura      \
    chromium xclip nvidia syncplay     \
    ttf-liberation htop discord        \
    numix-frost-themes llvm clang      \
    numix-icon-theme-pack-git megasync \
    zsh oh-my-zsh-git zsh-pure-prompt  \
    zsh-fast-syntax-highlighting-git   \
    zsh-autosuggestions yay feh maim   \
    skim ripgrep fd alsa-utils dunst   \
    rofi dmenu openssh wmctrl wget     \
    lemonbar-git inotify-tools lynx    \
    uni2ascii ttf-unifont

code --install-extension shan.code-settings-sync

sudo systemctl enable gdm.service
sudo systemctl enable NetworkManager.service

chsh -s /usr/bin/zsh
./link-up.sh
