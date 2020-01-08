#!/bin/bash

picom &
redshift -P &
xset -b &
alsactl restore -f /home/dmr/.asound &
flameshot &
/bin/bash ~/scripts/dwm-status.sh &
/bin/bash ~/scripts/wp-change.sh &
sleep 3
fcitx &
sleep 1
xmodmap ~/.xmodmap &

