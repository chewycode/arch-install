#!/usr/bin/env bash

read -p "Enter computer name: " computername
if [[ -z "$userInput" ]]; then
   printf '%s\n' "No computer name entered. Exiting..."
   exit 1
fi

timedatectl set-ntp true

parted /dev/sda mklabel msdos
parted /dev/sda mkpart primary ext4 1MiB 100%
parted /dev/sda set 1 boot on
mkfs.ext4 /dev/sda1
mount /dev/sda1 /mnt

pacstrap /mnt base base-devel linux linux-firmware sudo nano pacman-contrib curl git wget grub dhcpcd 
genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt

mv /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
curl -s "https://www.archlinux.org/mirrorlist/?country=US&protocol=https&use_mirror_status=on" | sed -e 's/^#Server/Server/' -e '/^#/d' | rankmirrors -n 5 - > /etc/pacman.d/mirrorlist

ln -sf /usr/share/zoneinfo/US/Central /etc/localtime
hwclock --systohc
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
echo LANG=en_US.UTF-8 > /etc/locale.conf

grub-install --recheck --target=i386-pc /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg

systemctl enable dhcpcd

echo "Enter root password..."
passwd

echo "$computername" > /etc/hostname
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1 localhost" >> /etc/hosts
echo "127.0.1.1 $computername" >> /etc/hosts

exit
reboot