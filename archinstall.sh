#!/usr/bin/env bash

timedatectl set-ntp true

parted /dev/sda mklabel msdos
parted /dev/sda mkpart primary ext4 1MiB 100%
parted /dev/sda set 1 boot on
mkfs.ext4 /dev/sda1
mount /dev/sda1 /mnt

pacstrap /mnt base base-devel linux linux-firmware sudo nano pacman-contrib curl git wget grub dhcpcd xdg-user-dirs
genfstab -U /mnt >> /mnt/etc/fstab
mkdir /mnt/root/arch-install
cp -ar /root/arch-install/ /mnt/root/
arch-chroot /mnt /root/arch-install/chroot.sh

reboot
