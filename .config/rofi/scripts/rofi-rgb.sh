#!/usr/bin/env bash

DIR="$HOME/.config/rofi"
rofi_command="rofi -theme $DIR/themes-scripts/rofi-rgb.rasi"

#Buttons
OptBlue="Blue"
OptWhite="White"
OptPink="Pink"
OptRed="Red"
OptGreen="Green"
OptCyan="Cyan"
OptRainbow="Rainbow"

options="$OptBlue\n$OptWhite\n$OptPink\n$OptRed\n$OptGreen\n$OptCyan"

chosen="$(echo -e "$options" | $rofi_command -p 'Select RGB Color' -dmenu -selected-row 0)"

case $chosen in
	$OptBlue)
		cd $HOME/.config/OpenRGB && openrgb --profile Blue.orp
		;;
	$OptWhite)
		cd $HOME/.config/OpenRGB && openrgb --profile White.orp
		;;
	$OptPink)
		cd $HOME/.config/OpenRGB && openrgb --profile Pink.orp
		;;
	$OptRed)
		cd $HOME/.config/OpenRGB && openrgb --profile Red.orp
		;;
	$OptGreen)
		cd $HOME/.config/OpenRGB && openrgb --profile Green.orp
		;;
	$OptCyan)
		cd $HOME/.config/OpenRGB && openrgb --profile Cyan.orp
		;;	
esac
