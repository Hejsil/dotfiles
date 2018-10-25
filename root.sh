#!/bin/sh
adduser -m hejsil

ip l
echo "Enter interface to run dhcpcd on."
read INTERFACE
systemctl enable "dhcpcd@$INTERFACE.service"

pacman -S sudo
sed -i 's/# ALL/ALL/' /etc/sudoers
