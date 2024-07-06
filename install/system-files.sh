#!/bin/sh -e

sudo cp -ri "$HOME/.config/pacman.conf" '/etc/pacman.conf'
sudo cp -ri "$HOME/.config/systemd-system/getty@tty1.service.d" '/etc/systemd/system/'
sudo cp -ri "$HOME"/config/sysctl.d/* '/etc/sysctl.d/'
