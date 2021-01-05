#!/bin/sh

. "$(pwd)/.profile"
ln -snf "$(pwd)/.bash_profile" "$HOME/.bash_profile"
ln -snf "$(pwd)/.bashrc" "$HOME/.bashrc"
ln -snf "$(pwd)/.config" "$HOME/.config"
ln -snf "$(pwd)/.ignore" "$HOME/.ignore"
ln -snf "$(pwd)/.local/script" "$HOME/.local/script"
ln -snf "$(pwd)/.local/share/anilist" "$HOME/.local/share/anilist"
ln -snf "$(pwd)/.local/share/zls" "$HOME/.local/share/zls"
ln -snf "$(pwd)/.profile" "$HOME/.profile"
ln -snf "$(pwd)/.xsession" "$HOME/.xsession"
ln -sf "$(which open)" "$HOME/.local/script/xdg-open"
generate kitty
generate xresources
generate dunstrc
generate gtk_theme

