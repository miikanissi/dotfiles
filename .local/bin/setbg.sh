#!/bin/bash

get_active_monitors()
{
    xrandr | awk '/\ connected/ && /[[:digit:]]x[[:digit:]].*+/{print $1}'
}
COUNT=$(get_active_monitors | wc -l)

[ -f "$1" ] && cp "$1" ~/.local/share/wall.jpg
[ -f "$2" ] && cp "$2" ~/.local/share/wall-vertical.jpg

if [ "$COUNT" -eq 2 ]; then
  feh --no-fehbg --bg-scale ~/.local/share/wall.jpg --bg-scale ~/.local/share/wall-vertical.jpg
elif [ "$COUNT" -gt 2 ]; then
  feh --no-fehbg --bg-scale ~/.local/share/wall.jpg --no-fehbg --bg-scale ~/.local/share/wall.jpg --no-fehbg --bg-scale ~/.local/share/wall-vertical.jpg
else
  feh --no-fehbg --bg-scale ~/.local/share/wall.jpg
fi
