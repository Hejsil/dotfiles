#!/bin/sh
adduser -m hejsil

ip l
echo "Enter interface to run dhcpcd on."
read INTERFACE
systemctl enable "dhcpcd@$INTERFACE.service"

pacman -S sudo
sed -i 's/# ALL/ALL/' /etc/sudoers

# Disable overcommit, because I really don't want it to
# stall my system when someone hogs all the memory.
echo "vm.overcommit_memory = 2" >> /etc/sysctl.conf
echo "vm.overcommit_kbytes = 0" >> /etc/sysctl.conf
