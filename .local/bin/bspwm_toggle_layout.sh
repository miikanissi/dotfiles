#!/bin/bash

# Check if the focused node is floating
if bspc query -N -n focused.floating.window >/dev/null; then
	# If it's floating, toggle fullscreen mode
	bspc node focused -t fullscreen

# Check if the focused node is fullscreen
elif bspc query -N -n focused.fullscreen.window >/dev/null; then
	bspc node focused -t floating

else
	# Query the current layout of the desktop
	current_layout=$(bspc query -T -d | jq -r '.layout')

	if [ "$current_layout" = "tiled" ]; then
		# If the layout is tiled, switch to monocle (fullscreen mode)
		bspc desktop -l monocle
	else
		# If the layout is monocle (fullscreen), switch to tiled
		bspc desktop -l tiled
	fi
fi
