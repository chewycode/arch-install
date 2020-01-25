#!/usr/bin/env bash

# install xorg
sudo pacman -S open-vm-tools xf86-input-vmmouse xf86-video-vmware mesa --noconfirm --needed

# enable services
sudo systemctl enable --now vmtoolsd.service
sudo systemctl enable --now vmware-vmblock-fuse.service

# sync time with host
vmware-toolbox-cmd timesync enable
