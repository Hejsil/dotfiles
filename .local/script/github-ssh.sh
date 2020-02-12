#!/bin/sh
git config --global user.email 'jhc@dismail.de'
git config --global user.name 'Jimmi Holst Christensen'
ssh-keygen -t rsa -b 4096 -C 'jhc@dismail.de'
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa
xclip -sel clip < ~/.ssh/id_rsa.pub
