#!/bin/sh -e

sudo cp -ri "$HOME/.config/systemd-system/getty@tty1.service.d" '/etc/systemd/system/'
