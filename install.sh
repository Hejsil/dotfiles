#!/bin/sh
ln -snf "$(pwd)/.bash_profile" "$HOME/.bash_profile"
ln -snf "$(pwd)/.bashrc" "$HOME/.bashrc"
ln -snf "$(pwd)/.config" "$HOME/.config"
ln -snf "$(pwd)/.ignore" "$HOME/.ignore"
ln -snf "$(pwd)/.local/script" "$HOME/.local/script"
ln -snf "$(pwd)/.local/share/anilist" "$HOME/.local/share/anilist"
ln -snf "$(pwd)/.profile" "$HOME/.profile"
ln -snf "$(pwd)/.xsession" "$HOME/.xsession"
