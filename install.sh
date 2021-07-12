#!/bin/sh

. "$(pwd)/config/profile"

ln -snf "$(pwd)/config" "$HOME/.config"
ln -snf "$(pwd)/local" "$HOME/.local"

ln -snf "$(pwd)/config/profile" "$HOME/.bash_profile"
ln -snf "$(pwd)/config/profile" "$HOME/.profile"

ln -snf "$(pwd)/config/bashrc" "$HOME/.bashrc"
ln -snf "$(pwd)/config/xorg/init" "$HOME/.xsession"

generate xresources
generate dunstrc
generate gtk_theme
