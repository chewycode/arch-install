#!/usr/bin/env bash
# this runs after you enter arch-chroot

# get user input for computer name
read -p "Enter computer name: " computername
while [ -z "$computername" ]
do
        read -p "Error! Please enter computer name: " computername
done
echo
echo "Computer name set as $computername"
echo

# get user name
read -p "Enter username to create: " username
while [ -z "$username" ]
do
        read -p "Error! Please enter new username: " username
done

# Add user
echo
useradd -m -G wheel,users -s /bin/bash $username
echo "Choose password for $username"
passwd $username

# edit sudoers file
echo
echo "Editing sudoers file"
echo '%wheel ALL=(ALL:ALL) ALL' | sudo EDITOR='tee -a' visudo
echo "$username ALL=(ALL) NOPASSWD:ALL" | sudo EDITOR='tee -a' visudo
echo

#create swap file
read -p "Enter in swap file size in megabytes (example: 512, 4096, etc)
Leave blank to not create swap.
" swapsize
if [ -z "$swapsize" ]
then
        echo "swap file not created"
        echo
else
        dd if=/dev/zero of=/swapfile bs=1M count=$swapsize status=progress
        chmod 600 /swapfile
        mkswap /swapfile
        swapon /swapfile
        echo "/swapfile none swap defaults 0 0" >> /etc/fstab
        echo "$swapsize swapfile created"
        echo
fi

# update mirror list
echo "Optimizing mirrorlist"
mv /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
echo "Server = http://mirrors.advancedhosters.com/archlinux/$repo/os/$arch" >> /etc/pacman.d/mirrorlist
echo

# set locale stuff (change for your info)
echo "Setting up local stuff"
ln -sf /usr/share/zoneinfo/US/Central /etc/localtime
hwclock --systohc
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
echo LANG=en_US.UTF-8 > /etc/locale.conf
echo

# install grub
echo "Installing grub"
grub-install --recheck --target=i386-pc /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg
echo

# enable dhcpcd
echo "enabling dhcpcd"
systemctl enable dhcpcd
echo

# set root password
echo "Enter root password..."
passwd
echo

# set up network info
echo "$computername" > /etc/hostname
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1 localhost" >> /etc/hosts
echo "127.0.1.1 $computername" >> /etc/hosts

# create default directories in $HOME
xdg-user-dirs-update

exit
