#!/usr/bin/env bash

# +──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────+
# | ███████╗ ██████╗██████╗ ███████╗███████╗███╗   ██╗███████╗██╗  ██╗ ██████╗ ████████╗    ███████╗ ██████╗██████╗ ██╗██████╗ ████████╗ |
# | ██╔════╝██╔════╝██╔══██╗██╔════╝██╔════╝████╗  ██║██╔════╝██║  ██║██╔═══██╗╚══██╔══╝    ██╔════╝██╔════╝██╔══██╗██║██╔══██╗╚══██╔══╝ |
# | ███████╗██║     ██████╔╝█████╗  █████╗  ██╔██╗ ██║███████╗███████║██║   ██║   ██║       ███████╗██║     ██████╔╝██║██████╔╝   ██║    |
# | ╚════██║██║     ██╔══██╗██╔══╝  ██╔══╝  ██║╚██╗██║╚════██║██╔══██║██║   ██║   ██║       ╚════██║██║     ██╔══██╗██║██╔═══╝    ██║    |
# | ███████║╚██████╗██║  ██║███████╗███████╗██║ ╚████║███████║██║  ██║╚██████╔╝   ██║       ███████║╚██████╗██║  ██║██║██║        ██║    |
# | ╚══════╝ ╚═════╝╚═╝  ╚═╝╚══════╝╚══════╝╚═╝  ╚═══╝╚══════╝╚═╝  ╚═╝ ╚═════╝    ╚═╝       ╚══════╝ ╚═════╝╚═╝  ╚═╝╚═╝╚═╝        ╚═╝    |
# |                                               Maim version  By: QuantumWavves                                                        |
# +──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────+

DIR="$HOME/.config/rofi"
rofi_command="rofi -theme $DIR/themes-scripts/screenshot.rasi"

time=$(date +%Y-%m-%d-%H-%M-%S)
dir="$HOME/Pictures/Screenshots"
file="Cheese-${time}.png"

# Buttons
screen=""
area=""
window="缾"

# take shots
shotnow() {
	cd ${dir} && sleep 0.5 && maim -u -f png | tee "$file" | xclip -selection clipboard -t image/png
	dunstify -I ~/.config/dunst/icons/cheese128x128.png "~Cheese, screenshot save in ~/Pictures/Screenshots"
}

shotwin() {
	cd ${dir} && maim -u -f png -i $(xdotool getactivewindow) | tee "$file" | xclip -selection clipboard -t image/png
	dunstify -I ~/.config/dunst/icons/cheese128x128.png "~Cheese, screenshot save in ~/Pictures/Screenshots"
}

shotarea() {
	cd ${dir} && maim -u -f png -s -b 2 -c 0.35,0.55,0.85,0.25 -l | tee "$file" | xclip -selection clipboard -t image/png
	dunstify -I ~/.config/dunst/icons/cheese128x128.png "~Cheese, screenshot save in ~/Pictures/Screenshots"
}

#if [[ ! -d "$dir" ]]; then
#	mkdir -p "$dir"
#fi

# Variable passed to rofi
options="$screen\n$area\n$window"

chosen="$(echo -e "$options" | $rofi_command -p 'Take Screenshot' -dmenu -selected-row 0)"
case $chosen in
$screen)
	shotnow
	;;
$area)
	shotarea
	;;
$window)
	shotwin
	;;

esac
