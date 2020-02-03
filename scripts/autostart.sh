#!/bin/bash

picom &
redshift -P &
xset -b &
alsactl restore -f /home/dmr/.asound &
flameshot &
/bin/bash ./dwm-status.sh &
/bin/bash ./wp-change.sh &
sleep 3
fcitx &
sleep 1
xmodmap ~/.xmodmap &

