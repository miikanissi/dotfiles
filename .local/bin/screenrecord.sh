#!/bin/bash
# screenrecord gif script by Miika Nissi, https://github.com/miikanissi, https://miikanissi.com
# Dependencies: byzanz, slop, notify-send

filename=$(date +%F_%T).gif
filepath=~/Pictures/ss/$filename

# slop to get region, exit if cancelled
read -r X Y W H < <(slop -f "%x %y %w %h")
[ -z "$X" ] && exit 1

# uses slop to select a region for byzanz to capture
byzanz-record   \
  --cursor      \
  --verbose     \
  --delay=1     \
  --duration=5  \
  --x="$X"      \
  --y="$Y"      \
  --width="$W"  \
  --height="$H" \
  "$filepath"                                       \

# sends notification if saved succesfully.
if [ -f "$filepath" ]; then
    notify-send "Gif saved."
fi
