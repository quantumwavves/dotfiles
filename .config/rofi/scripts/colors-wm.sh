#!/usr/bin/env bash

dir="$HOME/.config/polybar"
DIR="$HOME/.config/rofi"
waldir="$HOME/.cache/wal/colors"
rofidir="$HOME/.config/rofi/colorized"
File="$HOME/.config/bspwm/bspwmrc"
rofi_command="rofi -theme $DIR/themes-scripts/rofi-bars-colors.rasi"

reload(){
	if grep -q 'Minimalist' $File
	then
		killall polybar
		bash $HOME/.config/polybar/Minimalist/launch.sh
	else
		killall polybar
		bash $HOME/.config/polybar/Japanese/launch.sh
	fi

}

color1(){
	sed -i '/maincolor =*/c\maincolor = ${xrdb:color1}' $dir/Japanese/colors.ini
	sed -i '/maincolor =*/c\maincolor = ${xrdb:color1}' $dir/Minimalist/colors.ini
	ac_color1="`cat $waldir | sed -n '2 p'`ff"
	sed -i "s/ac:.*/ac:$ac_color1;/" $rofidir/colors.rasi
}

color2(){
	sed -i '/maincolor =*/c\maincolor = ${xrdb:color2}' $dir/Japanese/colors.ini
	sed -i '/maincolor =*/c\maincolor = ${xrdb:color2}' $dir/Minimalist/colors.ini
	ac_color2="`cat $waldir | sed -n '3 p'`ff"
	sed -i "s/ac:.*/ac:$ac_color2;/" $rofidir/colors.rasi
}

color3(){
	sed -i '/maincolor =*/c\maincolor = ${xrdb:color3}' .$dir/Japanese/colors.ini
	sed -i '/maincolor =*/c\maincolor = ${xrdb:color3}' $dir/Minimalist/colors.ini
	ac_color3="`cat $waldir | sed -n '4 p'`ff"
	sed -i "s/ac:.*/ac:$ac_color3;/" $rofidir/colors.rasi
}

color4(){
	sed -i '/maincolor =*/c\maincolor = ${xrdb:color4}' $dir/Japanese/colors.ini
	sed -i '/maincolor =*/c\maincolor = ${xrdb:color4}' $dir/Minimalist/colors.ini
	ac_color4="`cat $waldir | sed -n '5 p'`ff"
	sed -i "s/ac:.*/ac:$ac_color4;/" $rofidir/colors.rasi
}

color5(){
	sed -i '/maincolor =*/c\maincolor = ${xrdb:color5}' $dir/Japanese/colors.ini
	sed -i '/maincolor =*/c\maincolor = ${xrdb:color5}' $dir/Minimalist/colors.ini
	ac_color5="`cat $waldir | sed -n '6 p'`ff"
	sed -i "s/ac:.*/ac:$ac_color5;/" $rofidir/colors.rasi
}

color6(){
	sed -i '/maincolor =*/c\maincolor = ${xrdb:color6}' $dir/Japanese/colors.ini
	sed -i '/maincolor =*/c\maincolor = ${xrdb:color6}' $dir/Minimalist/colors.ini
	ac_color6="`cat $waldir | sed -n '7 p'`ff"
	sed -i "s/ac:.*/ac:$ac_color6;/" $rofidir/colors.rasi
}

color7(){
	sed -i '/maincolor =*/c\maincolor = ${xrdb:color7}' $dir/Japanese/colors.ini
	sed -i '/maincolor =*/c\maincolor = ${xrdb:color7}' $dir/Minimalist/colors.ini
	ac_color7="`cat $waldir | sed -n '8 p'`ff"
	sed -i "s/ac:.*/ac:$ac_color7;/" $rofidir/colors.rasi
}

color8(){
	sed -i '/maincolor =*/c\maincolor = ${xrdb:color8}' $dir/Japanese/colors.ini
	sed -i '/maincolor =*/c\maincolor = ${xrdb:color8}' $dir/Minimalist/colors.ini
	ac_color8="`cat $waldir | sed -n '8 p'`ff"
	sed -i "s/ac:.*/ac:$ac_color8;/" $rofidir/colors.rasi
}

#Buttons
OptButton1="Color1"
OptButton2="Color2"
OptButton3="Color3"
OptButton4="Color4"
OptButton5="Color5"
OptButton6="Color6"
OptButton7="Color7"
OptButton8="Color8"

options="$OptButton1\n$OptButton2\n$OptButton3\n$OptButton4\n$OptButton5\n$OptButton6\n$OptButton7\n$OptButton8"
chosen="$(echo -e "$options" | $rofi_command -p 'Select Bar Color' -dmenu -selected-row 0)"

case $chosen in
	$OptButton1)
		color1
		reload
		;;
	$OptButton2)
		color2
		reload
		;;
	$OptButton3)
		color3
		reload
		;;
	$OptButton4)
		color4
		reload
		;;
	$OptButton5)
		color5
		reload
		;;
	$OptButton6)
		color6
		reload
		;;	
	$OptButton7)
		color7
		reload
		;;	
	$OptButton8)
		color8
		reload
		;;	
esac