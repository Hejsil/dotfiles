#!/bin/sh -e

cd "$(dirname "$0")/.."

sudo cp -ri 'config/systemd-system/getty@tty1.service.d' '/etc/systemd/system/'
sudo cp -ri 'config/pacman.conf' '/etc/pacman.conf'
