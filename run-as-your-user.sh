#!/bin/bash

# make picom(compton) autostart
mkdir -p ${HOME}/.config/autostart/
cat <<EOF > ${HOME}/.config/autostart/picom.desktop
[Desktop Entry]
Encoding=UTF-8
Type=Application
Name=Picom
Comment=X11 compositor
Exec= picom -b -d :0
OnlyShowIn=XFCE;
StartupNotify=false
Terminal=false
Hidden=false
EOF
