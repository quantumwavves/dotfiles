#!/usr/bin/env bash

# +──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────+
# | ███████╗ ██████╗██████╗ ███████╗███████╗███╗   ██╗███████╗██╗  ██╗ ██████╗ ████████╗    ███████╗ ██████╗██████╗ ██╗██████╗ ████████╗ |
# | ██╔════╝██╔════╝██╔══██╗██╔════╝██╔════╝████╗  ██║██╔════╝██║  ██║██╔═══██╗╚══██╔══╝    ██╔════╝██╔════╝██╔══██╗██║██╔══██╗╚══██╔══╝ |
# | ███████╗██║     ██████╔╝█████╗  █████╗  ██╔██╗ ██║███████╗███████║██║   ██║   ██║       ███████╗██║     ██████╔╝██║██████╔╝   ██║    |
# | ╚════██║██║     ██╔══██╗██╔══╝  ██╔══╝  ██║╚██╗██║╚════██║██╔══██║██║   ██║   ██║       ╚════██║██║     ██╔══██╗██║██╔═══╝    ██║    |
# | ███████║╚██████╗██║  ██║███████╗███████╗██║ ╚████║███████║██║  ██║╚██████╔╝   ██║       ███████║╚██████╗██║  ██║██║██║        ██║    |   
# | ╚══════╝ ╚═════╝╚═╝  ╚═╝╚══════╝╚══════╝╚═╝  ╚═══╝╚══════╝╚═╝  ╚═╝ ╚═════╝    ╚═╝       ╚══════╝ ╚═════╝╚═╝  ╚═╝╚═╝╚═╝        ╚═╝    |
# |                                               Scrot version  By: QuantumWavves                                                        |
# +──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────+

DIR="$HOME/.config/rofi"
rofi_command="rofi -theme $DIR/themes-scripts/screenshot.rasi"

#time=`date +%Y-%m-%d-%H-%M-%S`
dir="$HOME/Pictures/Screenshots"
#file="Screenshot_${time}.png"

# Buttons
screen=""
area=""
window="缾"
monitor=""

# take shots
shotnow () {
	cd ${dir} && sleep 0.5 && scrot 'Cheese_%y.%m.%-d_%H.%M.%S.png' -e 'xclip -selection clipboard -target image/png -i $f'
	notify-send "Copied to clipboard"
}
# take window
shotwin () {
	cd ${dir} && sleep 0.5 && scrot 'Cheese_%y.%m.%-d_%H.%M.%S.png' --focused --border -e 'xclip -selection clipboard -target image/png -i $f'
    	notify-send "Copied to clipboard"
}
# take area 
shotarea () {
	cd ${dir} && sleep 0.5 && scrot 'Cheese_%y.%m.%-d_%H.%M.%S.png' --select -e 'xclip -selection clipboard -target image/png -i $f'
	notify-send "Copied to clipboard"
}
#take monitor
#shotmonitor () {
#	cd ${dir} && sleep 0.5 
#	notify-send "Copied to clipboard"
#}

if [[ ! -d "$dir" ]]; then
	mkdir -p "$dir"
fi

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
	#$monitor
	#	shotmonitor
	#	;;

esac
