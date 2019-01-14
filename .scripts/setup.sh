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
    gdm openbox thunderbird sxiv       \
    visual-studio-code-bin deluge      \
    python2-gobject2 pygtk sakura      \
    chromium xclip nvidia syncplay     \
    htop discord lynx uni2ascii        \
    numix-frost-themes llvm clang      \
    numix-icon-theme-pack-git megasync \
    zsh oh-my-zsh-git zsh-pure-prompt  \
    zsh-fast-syntax-highlighting-git   \
    zsh-autosuggestions yay feh        \
    skim ripgrep fd alsa-utils dunst   \
    dmenu openssh wget wmctrl          \
    lemonbar-xft-git inotify-tools     \
    imagemagick maim xorg-xrandr       \
    ttf-font-awesome ttf-dejavu        \
    ttf-unifont ttf-liberation         \
    powerline-fonts

code --install-extension shan.code-settings-sync

sudo systemctl enable gdm.service
sudo systemctl enable NetworkManager.service

chsh -s /usr/bin/zsh
./link-up.sh
./clone.sh
