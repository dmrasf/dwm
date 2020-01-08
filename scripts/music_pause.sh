PP=$(mpc | awk '/\[p/ {print $1}' | sed -e 's/\[//; s/\]//')
case $PP in
    paused)
        mpc play ;;
    playing)
        mpc pause ;;
    *)
        ;;
esac
