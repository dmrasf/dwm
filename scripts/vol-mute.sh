ISMUTE=$(amixer get Master | awk '/Mono:/ {print $6}' | sed -e 's/\[//; s/\]//')

case $ISMUTE in
    on)
        amixer set Master mute ;;
    off)
        amixer set Master unmute ;;
    *)
        ;;
esac

