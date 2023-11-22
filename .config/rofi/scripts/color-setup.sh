#!/usr/bin/env bash

DIR="$HOME/.config/rofi/colorized"
polydir="$HOME/.config/polybar"
dir="$HOME/.cache/wal/colors"

bg_color="`cat $dir | sed -n '1 p'`ff"
ac_color="`cat $dir | sed -n '5 p'`ff"

set_colors(){
    sed -i '/maincolor =*/c\maincolor = ${xrdb:color4}' $polydir/Japanese/colors.ini
	sed -i '/maincolor =*/c\maincolor = ${xrdb:color4}' $polydir/Minimalist/colors.ini
    sed -i "s/bg:.*/bg:$bg_color;/" $DIR/colors.rasi
    sed -i "s/ac:.*/ac:$ac_color;/" $DIR/colors.rasi
}

set_colors
