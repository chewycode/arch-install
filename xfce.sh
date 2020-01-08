#!/usr/bin/env bash

# Install display server
pacman -S xorg-server xorg-apps xorg-xinit xterm --noconfirm --needed

# Install a display manager
pacman -S lightdm --noconfirm --needed
pacman -S lightdm-gtk-greeter lightdm-gtk-greeter-settings --noconfirm --needed
systemctl enable lightdm.service

# Install graphic envionment
pacman -S xfce4 xfce4-goodies --noconfirm --needed
