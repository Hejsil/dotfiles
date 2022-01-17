#!/bin/sh -e
update.sh
sudo grub-reboot "$(sudo grep -i 'windows' '/boot/grub/grub.cfg' | cut -d"'" -f2)"
exec sudo reboot
