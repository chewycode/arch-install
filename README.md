# arch-install
Basic bash script to install Arch Linux.

This installs Arch Linux onto 1 partion on /dev/sda.

<h3>Instructions</h3>

Download Arch Linux from https://www.archlinux.org/download/

Boot into installation.

Type this as soon as you are booted up...

pacman -Sy git<br>
git clone https://github.com/chewycode/arch-install.git<br>
cd arch-install<br>
chmod +x *<br>
sh archinstall.sh<br>
