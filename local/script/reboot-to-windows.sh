#!/bin/sh -e
update
sudo grub-reboot "$(sudo grep -i 'windows' '/boot/grub/grub.cfg' | cut -d"'" -f2)"
exec sudo reboot
