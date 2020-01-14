#!/usr/bin/env bash
echo
echo "Choose (2) virtualbox-guest-modules-arch"
echo
pacman -S virtualbox-guest-utils linux-headers --noconfirm --needed
systemctl enable vboxservice.service --now
echo
sudo cp /root/arch-install/config/picom.conf $HOME/.config/picom.conf
echo "Make sure graphics controller is set to VBoxSVGA in order for resolution to auto-adjust."
echo "In virtualbox menu go to Devices >> Shared Clipboard and select bidirectional"
