#!/usr/bin/env bash

echo "Genaerating .xinitrc file"

# Generate the .xinitrc file so we can launch XFCE from the
# terminal using the "startx" command
cat <<EOF > ${HOME}/.xinitrc
#!/bin/bash
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
    for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
        [ -x "\$f" ] && . "\$f"
    done
    unset f
fi
source /etc/xdg/xfce4/xinitrc
exit 0
EOF