#!/usr/bin/env bash

# install xorg
sudo pacman -S xorg xorg-xinit i3-gaps -noconfirm -needed

# Install fonts
sudo pacman -S noto-fonts ttf-ubuntu-font-family ttf-dejavu ttf-freefont ttf-liberation ttf-droid ttf-inconsolata ttf-roboto terminus-font ttf-font-awesome -noconfirm -needed

# Install audio stuff
pacman -S alsa-utils alsa-plugins pulseaudio pulseaudio-alsa pavucontrol --noconfirm --needed

# basic terminal stuff
sudo pacman -S rxvt-unicode ranger rofi conky dmenu -noconfirm -needed

# terminal and ranger tools
sudo pacman -S atool highlight browsh elinks mediainfo w3m ffmpegthumbnailer mupdf -noconfirm -needed

#configure startx command
echo "exec i3" > $HOME/.xinitrc
