#!/usr/bin/env bash

DIR="$HOME/.config/bspwm/bspwmrc"
dir="$HOME/.config/rofi/themes-scripts"
rofi_command="rofi -show drun -theme $dir/vsync.rasi"
state=""

define_state(){
    if grep -q 'picom &' $DIR
    then
        state="ON"
    else
        state="OFF"
    fi
}

vsync_off(){
    if grep -q 'picom &' $DIR
    then
        sed -i '/picom\ &/c\picom\ --no-vsync\ &' $DIR
        bspc wm -r
    else
        state="OFF"
        rofi -theme "$dir/message.rasi" -e "Vsync is already disabled"
    fi
}

vsync_on(){
    if grep -q 'picom --no-vsync &' $DIR
    then
        sed -i '/picom\ --no-vsync\ &/c\picom\ &' $DIR
         bspc wm -r
    else
        state="ON"
        rofi -theme "$dir/message.rasi" -e "Vsync is alredy enable"
    fi
}

#Define the state
define_state

#Buttons
power_on=":ON"
power_off=":OFF"
status="=$state"

options="$power_on\n$power_off\n$status"

chosen="$(echo -e "$options" | $rofi_command -p 'Select vsync status' -dmenu -selected-row 0)"

case $chosen in
	$power_on)
		vsync_on
		;;
	$power_off)
		vsync_off
		;;
esac
