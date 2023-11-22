#/usr/bin/env bash

DIR="$HOME/.config/bspwm/bspwmrc"
dir="$HOME/.config/rofi/themes-scripts"
rofi_command="rofi -show drun -theme $dir/bars.rasi"

#Menu for bar settings

switchJapanese(){
    if grep 'Minimalist' -q $DIR
    then
        sed -i "s/Minimalist/Japanese/g" $DIR
        killall polybar
	bash ~/.config/polybar/Japanese/launch.sh
    fi
}

switchMinimalist(){
    if grep -q 'Japanese' -q $DIR
    then
        sed -i "s/Japanese/Minimalist/g" $DIR
        killall polybar
	bash ~/.config/polybar/Minimalist/launch.sh 
    fi
}


#Options
Japan="Japanese"
Minimal="Minimalist"


options="$Japan\n$Minimal"

chosen="$(echo -e "$options" | $rofi_command -p 'Select bar type' -dmenu -selected-row 0)"

case $chosen in
	$Japan)
		switchJapanese
		;;
	$Minimal)
		switchMinimalist
		;;
esac
