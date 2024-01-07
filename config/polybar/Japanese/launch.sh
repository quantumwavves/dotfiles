#!/usr/bin/env bash

## Files and Directories
DIR="$HOME/.config/polybar"
# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

## Launch Polybar with selected style
launch_bar() {
	if [[ ! $(pidof polybar) ]]; then
		polybar -q bar -c "$DIR"/Japanese/config.ini &
	else
		polybar-msg cmd restart
	fi
}

launch_bar
