#!/bin/bash
rofi_command="rofi -theme .config/rofi/PowerMenu/powermenu.rasi"

# Options
shutdown="   Shutdown"
reboot="   Reboot"
lock="   Lock"
suspend="   Suspend"
logout="   Logout"

# Variable passed to rofi
options="$lock\n$suspend\n$logout\n$reboot\n$shutdown"

chosen="$(echo -e "$options" | $rofi_command -dmenu -p "  ")"
case $chosen in
    $shutdown)
        systemctl poweroff
        ;;
    $reboot)
        systemctl reboot
        ;;
    $lock)
        i3lock
        ;;
    $suspend)
        systemctl suspend
        ;;
    $logout)
        i3-msg exit
        ;;
esac
