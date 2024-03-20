#!/bin/bash

# define the lid switch actions
# - suspend
# - hibernate
# - ignore
# - poweroff
# - reboot
# - halt 
# - kexec
# - hybrid-sleep
# - lock
LID_SWITCH_ACTION_BAT=suspend
LID_SWITCH_ACTION_AC=ignore


# Brightness settings using xbacklight in percent, uncoment if needed
#BRIGHTNESS_BAT=35
#BRIGHTNESS_AC=90

# set by 02-lid.rules
case "$1" in 

battery)
    sed -i "s/^.*\bHandleLidSwitch\b.*$/HandleLidSwitch=$LID_SWITCH_ACTION_BAT/" /etc/systemd/logind.conf
    #/usr/bin/xbacklight -set $BRIGHTNESS_BAT
    systemctl restart systemd-logind
    ;;
AC)
    sed -i "s/^.*\bHandleLidSwitch\b.*$/HandleLidSwitch=$LID_SWITCH_ACTION_AC/" /etc/systemd/logind.conf
    #/usr/bin/xbacklight -set $BRIGHTNESS_AC
    systemctl restart systemd-logind
    ;;
esac