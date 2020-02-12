#!/bin/sh
yay -Syu --noconfirm
sudo grub-reboot "$(sudo grep -i 'windows' '/boot/grub/grub.cfg' | cut -d"'" -f2)" && sudo reboot
