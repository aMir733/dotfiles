#!/usr/bin/env bash

## Author  : Aditya Shakya
## Mail    : adi1090x@gmail.com
## Github  : @adi1090x
## Twitter : @adi1090x

killall rofi 2>/dev/null && exit 0


# accent colors
COLORS=('#EC7875' '#61C766' '#FDD835' '#42A5F5' '#BA68C8' '#4DD0E1' '#00B19F' \
                '#FBC02D' '#E57C46' '#AC8476' '#6D8895' '#EC407A' '#B9C244' '#6C77BB')
ACCENT="${COLORS[$(( $RANDOM % 14 ))]}ff"

# overwrite colors file
cat << EOF > "$HOME/.config/rofi/powermenu/colors.rasi"
* {
    accent:           $ACCENT;
    background:       #000000;
    background-light: #000000;
    foreground:       #93a1a1;
    on:               #5BB462;
    off:              #DE635E;
}
EOF

dir="$HOME/.config/rofi/powermenu"
style="rounded"
rofi_command="rofi -theme $dir/$style.rasi"

uptime=$(uptime -p | sed -e 's/up //g')

# Options
shutdown=""
reboot=""
#lock=""
#suspend=""
logout=""

# Confirmation
confirm_exit() {
    if ! [[ $(echo -e "No\nYes" | $rofi_command -p "Are you sure?" -dmenu -selected-row 2) == Yes ]] ; then
        exit 0
    fi
}

# Message
msg() {
	rofi -theme "$HOME/.config/rofi/powermenu/message.rasi" -e "Available Options  -  yes / y / no / n"
}

# Variable passed to rofi
options="$shutdown\n$reboot\n$logout"

chosen="$(echo -e "$options" | $rofi_command -p "UP - $uptime" -dmenu -selected-row 2)"
case $chosen in
    $shutdown)
	    confirm_exit
            sudo /sbin/poweroff
        ;;
    $reboot)
            confirm_exit
	    sudo /sbin/reboot
        ;;
#    $lock)
#		if [[ -f /usr/bin/i3lock ]]; then
#			i3lock
#		elif [[ -f /usr/bin/betterlockscreen ]]; then
#			betterlockscreen -l
#		fi
#        ;;
#    $suspend)
#		ans=$(confirm_exit &)
#		if [[ $ans == "yes" || $ans == "YES" || $ans == "y" || $ans == "Y" ]]; then
#			mpc -q pause
#			amixer set Master mute
#			systemctl suspend
#		elif [[ $ans == "no" || $ans == "NO" || $ans == "n" || $ans == "N" ]]; then
#			exit 0
#        else
#			msg
#        fi
#        ;;
    $logout)
            confirm_exit
            pkill -u amir
        ;;
esac
