#!/bin/sh
# screenshot script by Miika Nissi, https://github.com/miikanissi, https://miikanissi.com
# Dependencies: maim, ifne(moreutils), xclip

filename=$(date +%F_%T).png
filepath=~/Pictures/ss/$filename

# takes screenshot of selected region
# pipes into ifne which checks if output is empty
# if not empty tee saves image and passes standard output onto
# xclip for easy pasting
maim -s -u -q | ifne tee "$filepath" | xclip -selection clipboard -t image/png

# sends notification if saved succesfully.
if [ -f "$filepath" ]; then
	notify-send "Screenshot saved."
fi
