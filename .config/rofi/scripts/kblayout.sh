#!/usr/bin/env sh

DIR="$HOME/.config/bspwm/bspwmrc"
dir="$HOME/.config/rofi/themes-scripts"
rofi_command="rofi -show drun -theme $dir/kb.rasi"

EspLayout(){
	setxkbmap latam
}

UsLayout(){
	setxkbmap us
}

ESP="Spanish"
US="English"


options="$ESP\n$US"

chosen="$(echo -e "$options" | $rofi_command -p 'Select kb layout' -dmenu -selected-row 0)"

case $chosen in
	$US)
		UsLayout
		;;
	$ESP)
		EspLayout
		;;	
esac
