#!/bin/sh
# screenrecord gif script by Miika Nissi, https://github.com/miikanissi, https://miikanissi.com
# Dependencies: byzanz, slop, notify-send

filename=$(date +%F_%T).gif
filepath=~/Pictures/ss/$filename

# uses slop to select a region for byzanz to capture
byzanz-record                                       \
  --cursor                                          \
  --verbose                                         \
  --delay=1                                         \
  --duration=5                                      \
  $(slop -f "--x=%x --y=%y --width=%w --height=%h") \
  "$filepath"                                       \

# sends notification if saved succesfully.
if [ -f $filepath ]; then
    notify-send "Gif saved."
    xclip -selection clipboard -t image/gif < "$filepath"
fi
