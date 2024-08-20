#!/bin/bash

# Monitor resolution
SCREEN_WIDTH=1920
SCREEN_HEIGHT=1080

# Manual padding values to account for taskbar, etc.
PADDING_TOP=32
PADDING_RIGHT=0
PADDING_BOTTOM=0
PADDING_LEFT=0

# Function to display help
show_help() {
	printf "Usage: %s [OPTION]\nOptions:\n  -w    Move the window west to x=%d\n  -e    Move the window east to x=%d\n  -n    Move the window north to y=%d\n  -s    Move the window south to y=%d\n  -c    Center the window on the screen\n  -h    Show this help message\n" "$0" "$PADDING_LEFT" "$((SCREEN_WIDTH - PADDING_RIGHT))" "$PADDING_TOP" "$((SCREEN_HEIGHT - PADDING_BOTTOM))"
}

# Initialize variables
direction=""

# Use getopts to handle short flags
while getopts "wensch" opt; do
	case "$opt" in
	w)
		direction="west"
		;;
	e)
		direction="east"
		;;
	n)
		direction="north"
		;;
	s)
		direction="south"
		;;
	c)
		direction="center"
		;;
	h)
		show_help
		exit 0
		;;
	*)
		printf "Error: Invalid option. Use -h for usage information.\n"
		exit 1
		;;
	esac
done

# If direction is still empty, show help
if [ -z "$direction" ]; then
	show_help
	exit 1
fi

# Retrieve the focused node JSON output
output=$(bspc query -T -n focused)

# Retrieve the desktop JSON output to get border width
desktop_output=$(bspc query -T --desktop)
border_width=$(printf "%s" "$desktop_output" | jq '.borderWidth')

# Check if floatingRectangle exists
if printf "%s" "$output" | jq -e '.client.floatingRectangle' >/dev/null 2>&1; then
	# Extract X, Y, Width, and Height from the floatingRectangle
	x_position=$(printf "%s" "$output" | jq '.client.floatingRectangle.x')
	y_position=$(printf "%s" "$output" | jq '.client.floatingRectangle.y')
	width=$(printf "%s" "$output" | jq '.client.floatingRectangle.width')
	height=$(printf "%s" "$output" | jq '.client.floatingRectangle.height')

	# Calculate the adjustments needed based on the direction
	case "$direction" in
	west)
		delta_x=$((PADDING_LEFT - x_position))
		delta_y=0
		;;
	east)
		delta_x=$((SCREEN_WIDTH - (x_position + width + 2 * border_width) - PADDING_RIGHT))
		delta_y=0
		;;
	north)
		delta_x=0
		delta_y=$((PADDING_TOP - y_position))
		;;
	south)
		delta_x=0
		delta_y=$((SCREEN_HEIGHT - (y_position + height + 2 * border_width) - PADDING_BOTTOM))
		;;
	center)
		center_x=$(((SCREEN_WIDTH - width - PADDING_LEFT - PADDING_RIGHT) / 2 + PADDING_LEFT))
		center_y=$(((SCREEN_HEIGHT - height - PADDING_TOP - PADDING_BOTTOM) / 2 + PADDING_TOP))
		delta_x=$((center_x - x_position))
		delta_y=$((center_y - y_position))
		;;
	esac

	# Move the node using bspc
	bspc node focused --move "$delta_x" "$delta_y"

else
	# Handle the case where floatingRectangle does not exist
	printf "Error: floatingRectangle not found in the JSON output.\n"
	exit 1
fi
