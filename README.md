# arch-install
Basic bash script to install Arch Linux.

This installs Arch Linux onto 1 partion on /dev/sda.
This does not create a swap partition.  It creates a swap file which is easier to resize in the future.

<h3>Instructions</h3>

Download Arch Linux from https://www.archlinux.org/download/

Boot into installation.

Type this as soon as you are booted up...

pacman -Sy git<br>
git clone https://github.com/chewycode/arch-install.git<br>
cd arch-install<br>
chmod +x *<br>
sh archinstall.sh<br>
