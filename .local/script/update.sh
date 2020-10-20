#!/bin/sh -e

yay -Syu --noconfirm
yay -Yc --noconfirm
nvim +PlugInstall +PlugUpdate +UpdateRemotePlugins +qa

