#!/bin/bash

music() {
    PP=$(mpc | awk '/\[p/ {print $1}' | sed -e 's/\[//; s/\]//')
    case $PP in
        paused)
            echo  $(mpc | sed -n '1p') ;;
        playing)
            echo  $(mpc | sed -n '1p') ;;
        *)
            echo ﱙ ;;
    esac
}

bat() {
    BAT_N=$(acpi -b | awk '{ print $3}' | sed 's/,//')
    BAT=$(acpi -b | awk '{ print $4}' | sed 's/,//')
    case $BAT_N in
    Discharging)
        echo  $BAT ;;
    Charging)
        echo  $BAT ;;
    Full)
        echo  $BAT ;;
    *)
        echo  $BAT ;;
    esac
}
vol() {
    ISMUTE=$(amixer get Master | awk '/Mono:/ {print $6}' | sed -e 's/\[//; s/\]//')
    VOL=$(amixer get Master | awk '/Mono:/ {print $4}' | sed -e 's/\[//; s/\]//')
    case $ISMUTE in
        on)
            echo  $VOL ;;
        off)
            echo ﱝ $VOL ;;
        *)
            ;;
    esac
}
mem() {
    echo  $(free -h | awk '/^Mem:/ {print $3 "/" $2}' | sed 's/i//g')
}
cpu_temp() {
    echo  $(sensors | awk '/Core 0/ {print $3}')
}
disk() {
    echo  $(df -hl | awk '/dev\/nvme0n1p4/ {print $4 "/" $2}')
}

net() {
    ISCON=$(nmcli -a | awk '/^wlp3s0:/ {print $4}')
    
    if [ -z "$ISCON" ]; then
        echo 睊
    else
        echo $ISCON $(netspeed)
    fi
}
netspeed() {
    RX_pre=$(cat /proc/net/dev | awk '/wlp3s0:/ { print $2 }')
    TX_pre=$(cat /proc/net/dev | awk '/wlp3s0:/ { print $10 }')
    sleep 1
    RX_next=$(cat /proc/net/dev | awk '/wlp3s0:/ { print $2 }')
    TX_next=$(cat /proc/net/dev | awk '/wlp3s0:/ { print $10 }')
    
    RX=$((${RX_next}-${RX_pre}))
    TX=$((${TX_next}-${TX_pre}))
    
    if [[ $RX -lt 1024 ]]; then
        RX="${RX}B/s"
    elif [[ $RX -gt 1048576 ]]; then
        RX=$(echo $RX | awk '{ printf("%.1fMB/s",$1/1048576) }')
    else
        RX=$(echo $RX | awk '{ printf("%.1fKB/s",$1/1024) }')
    fi
     
    if [[ $TX -lt 1024 ]]; then
        TX="${TX}B/s"
    elif [[ $TX -gt 1048576 ]]; then
        TX=$(echo $TX | awk '{ printf("%.1fMB/s",$1/1048576) }')
    else
        TX=$(echo $TX | awk '{ printf("%.1fKB/s",$1/1024) }')
    fi
    
    echo ⬇$RX ⬆$TX
}
update() {
    echo  $(checkupdates | wc -l) 
}
localtime() {
    echo $(date +'%m-%d %H:%M %A')
}

while true
do 
    xsetroot -name " $(net) | $(bat) | $(vol) | $(mem) | $(disk) | $(localtime)  "
	sleep 5s
done
#done
