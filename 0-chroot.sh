#!/usr/bin/env bash
#this runs after arch-chroot

read -p "Enter computer name: " computername
if [[ -z "$computername" ]]; then
   printf '%s\n' "No computer name entered. Exiting..."
   exit 1
fi

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