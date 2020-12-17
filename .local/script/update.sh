#!/bin/sh -e

yay -Syu --noconfirm
yay -Yc --noconfirm
# nvim +PlugClean +PlugInstall +PlugUpdate +UpdateRemotePlugins +qa

