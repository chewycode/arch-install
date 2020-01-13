#!/usr/bin/env bash
echo
echo "Choose (2) virtualbox-guest-modules-arch"
echo
pacman -S virtualbox-guest-utils linux-headers --noconfirm --needed
echo
echo "Make sure graphics controller is set to VBoxSVGA in order for resolution to auto-adjust."
echo
