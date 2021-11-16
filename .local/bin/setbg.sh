#!/bin/sh

[ -f "$1" ] && cp "$1" ~/.local/share/wall.jpg
[ -f "$2" ] && cp "$2" ~/.local/share/wall-vertical.jpg
feh --no-fehbg --bg-scale ~/.local/share/wall.jpg --no-fehbg --bg-scale ~/.local/share/wall-vertical.jpg
# xwallpaper --zoom ~/.config/gallery/wall.jpg
