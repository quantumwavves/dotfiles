#!/usr/bin/env bash

DIR="$HOME/.config/rofi/themes-scripts"
dir="$HOME/.config/rofi/scripts"
rofi_command="rofi -show drun -theme $DIR/settings.rasi"
#Buttons

bars="Bars"
shell="Terminal"
vsync="Vsync"
Colors="Colors"

options="$bars\n$shell\n$vsync\n$Colors"

chosen="$(echo -e "$options" | $rofi_command -p 'Settings Menu' -dmenu -selected-row 0)"

case $chosen in
	$bars)
		sh $dir/bars.sh
		;;
	$shell)
		sh $dir/background-term.sh
		;;
    $vsync)
        sh $dir/vsync-compositor.sh
        ;;
	$Colors)
		sh $dir/colors-wm.sh
esac
