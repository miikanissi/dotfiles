#!/usr/bin/env bash

cur_sink=$(pactl list short sinks | sed -e 's,^\([0-9][0-9]*\)[^0-9].*,\1,' | head -n 1)

case $BUTTON in
	1) pactl set-sink-mute "$cur_sink" toggle ;;
	3) pavucontrol ;;
	4) pactl set-sink-volume "$cur_sink" +5% ;;
	5) pactl set-sink-volume "$cur_sink" -5% ;;
esac

muted=$(pactl list sinks | grep '^[[:space:]]Mute:' | head -n $(($cur_sink + 1)) | tail -n 1 | awk '{print $2}')
[ "$muted" == "yes" ] && echo ﱝ muted && exit

volume=$(pactl list sinks | grep '^[[:space:]]Volume:' | head -n $(($cur_sink + 1)) | tail -n 1 | sed -e 's,.* \([0-9][0-9]*\)%.*,\1,')

if [[ "$volume" -gt "70" ]]; then
  icon=""
elif [[ "$volume" -lt "30" ]]; then
	icon=""
else
	icon=""
fi

echo "$icon $volume%"
