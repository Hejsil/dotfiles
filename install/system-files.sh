#!/bin/sh -e

cd "$(dirname "$0")/.."

sudo cp -ri 'config/grub' '/etc/default/grub'
sudo cp -ri 'config/pacman.conf' '/etc/pacman.conf'
sudo cp -ri 'config/systemd/journald.conf' '/etc/systemd/journald.conf'
sudo cp -ri 'config/systemd-system/getty@tty1.service.d' '/etc/systemd/system/'
sudo cp -ri config/modprobe.d/* '/etc/modprobe.d/'
sudo cp -ri config/sysctl.d/* '/etc/sysctl.d/'
sudo cp -ri config/xorg.conf.d/* '/etc/X11/xorg.conf.d/'
