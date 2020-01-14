#!/usr/bin/env bash

# Install display server
pacman -S xorg-server xorg-apps xorg-xinit xterm --noconfirm --needed

# Install a display manager
pacman -S lightdm --noconfirm --needed
pacman -S lightdm-gtk-greeter lightdm-gtk-greeter-settings --noconfirm --needed
systemctl enable lightdm.service

# Install graphic envionment
pacman -S xfce4 xfce4-goodies picom --noconfirm --needed

# Install audio stuff
pacman -S alsa-utils alsa-plugins pulseaudio pulseaudio-alsa pavucontrol --noconfirm --needed

# turn off xfwm4's compositing feature
xfconf-query -c xfwm4 -p /general/use_compositing -s false

# Install the rest of packages
PKGS=(
            # ----------Printer Setup-----------------------------
            
            'cups'                  # Open source printer drivers
            'cups-pdf'              # PDF support for cups
            'ghostscript'           # PostScript interpreter
            'gsfonts'               # Adobe Postscript replacement fonts
            'system-config-printer' # Printer setup  utility
            
            # ----------Fonts-------------------------------------
            
            'ttf-dejavu'
            'ttf-droid'
            'ttf-liberation'
            'terminus-font'         # Font package with some bigger fonts for login terminal
            
            # SYSTEM --------------------------------------------------------------

            'linux-lts'             # Long term support kernel
            'linux-lts-headers'     # Headers for linux-lts

            # TERMINAL UTILITIES --------------------------------------------------

            'bash-completion'       # Tab completion for Bash
            'cronie'                # cron jobs
            'file-roller'           # Archive utility
            'gtop'                  # System monitoring via terminal
            'hardinfo'              # Hardware info app
            'htop'                  # Process viewer
            'neofetch'              # Shows system info when you launch terminal
            'ntp'                   # Network Time Protocol to set time via network.
            'numlockx'              # Turns on numlock in X11
            'openssh'               # SSH connectivity tools
            'rsync'                 # Remote file sync utility
            'speedtest-cli'         # Internet speed via terminal
            'unrar'                 # RAR compression program
            'unzip'                 # Zip compression program
            'terminator'            # Terminal emulator
            'zenity'                # Display graphical dialog boxes via shell scripts
            'zip'                   # Zip compression program

            # DISK UTILITIES ------------------------------------------------------

            'autofs'                # Auto-mounter
            'gparted'               # Disk utility
            'ntfs-3g'               # Open source implementation of NTFS file system
            'parted'                # Disk utility

            # GENERAL UTILITIES ---------------------------------------------------

            'catfish'               # Filesystem search
            'veracrypt'             # Disc encryption utility
            'yay'                   # Install packages from AUR

            # WEB TOOLS -----------------------------------------------------------

            'filezilla'             # FTP Client
            'firefox'                # Web Browser

            # COMMUNICATIONS ------------------------------------------------------

            'hexchat'               # Multi format chat

            # MEDIA ---------------------------------------------------------------

            'vlc'                   # Video player

            # GRAPHICS AND DESIGN -------------------------------------------------
            
            'ristretto'             # Multi image viewer

            # PRODUCTIVITY --------------------------------------------------------

            'hunspell'              # Spellcheck libraries
            'hunspell-en'           # English spellcheck library
            'libreoffice-fresh'     # Libre office with extra features
            'xpdf'                  # PDF viewer
)

for PKG in "${PKGS[@]}"; do
    echo "INSTALLING ${PKG}"
    sudo pacman -S "$PKG" --noconfirm --needed
done

# ------------------------------------------------------------------------

echo
echo "Increasing file watcher count"

# This prevents a "too many files" error in Visual Studio Code
echo fs.inotify.max_user_watches=524288 | sudo tee /etc/sysctl.d/40-max-user-watches.conf && sudo sysctl --system

# ------------------------------------------------------------------------

echo
echo "Enabling the cups service daemon so we can print"

systemctl enable org.cups.cupsd.service

# ------------------------------------------------------------------------

echo
echo "Configuring LTS Kernel as a secondary boot option"

sudo cp /boot/loader/entries/arch.conf /boot/loader/entries/arch-lts.conf
sudo sed -i 's|Arch Linux|Arch Linux LTS Kernel|g' /boot/loader/entries/arch-lts.conf
sudo sed -i 's|vmlinuz-linux|vmlinuz-linux-lts|g' /boot/loader/entries/arch-lts.conf
sudo sed -i 's|initramfs-linux.img|initramfs-linux-lts.img|g' /boot/loader/entries/arch-lts.conf
