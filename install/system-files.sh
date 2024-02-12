#!/bin/sh -e

cd "$(dirname "$0")/.." || exit 1

sudo cp -ri 'config/pacman.conf' '/etc/pacman.conf'
sudo cp -ri 'config/systemd-system/getty@tty1.service.d' '/etc/systemd/system/'
sudo cp -ri config/modprobe.d/* '/etc/modprobe.d/'
sudo cp -ri config/sysctl.d/* '/etc/sysctl.d/'
