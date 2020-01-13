#!/usr/bin/env bash

# Install display server
pacman -S xorg-server xorg-apps xorg-xinit xterm --noconfirm --needed

# Install a display manager
pacman -S lightdm --noconfirm --needed
pacman -S lightdm-gtk-greeter lightdm-gtk-greeter-settings --noconfirm --needed
systemctl enable lightdm.service

# Install graphic envionment
pacman -S xfce4 xfce4-goodies --noconfirm --needed

# Install audio stuff
pacman -S alsa-utils alsa-plugins pulseaudio pulseaudio-alsa pavucontrol --noconfirm --needed

# Install the rest of packages
PKGS=(
            # ----------Printer Setup-----------------------------
            
            'cups'                  # Open source printer drivers
            'cups-pdf'              # PDF support for cups
            'ghostscript'           # PostScript interpreter
            'gsfonts'               # Adobe Postscript replacement fonts
            'hplip'                 # HP Drivers
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
            'firfox'                # Web Browser

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
echo "Configuring MAKEPKG to use all 4 cores"

sudo sed -i -e 's|[#]*MAKEFLAGS=.*|MAKEFLAGS="-j$(nproc)"|g' makepkg.conf
sudo sed -i -e 's|[#]*COMPRESSXZ=.*|COMPRESSXZ=(xz -c -T 4 -z -)|g' makepkg.conf

# ------------------------------------------------------------------------
echo
echo "Increasing file watcher count"

# This prevents a "too many files" error in Visual Studio Code
echo fs.inotify.max_user_watches=524288 | sudo tee /etc/sysctl.d/40-max-user-watches.conf && sudo sysctl --system
# ------------------------------------------------------------------------
echo
echo "Enabling the cups service daemon so we can print"

systemctl enable org.cups.cupsd.service
