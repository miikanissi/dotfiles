#!/bin/sh

[ -f "$1" ] && cp "$1" ~/.config/gallery/wall.jpg
feh --no-fehbg --bg-scale ~/.config/gallery/wall.jpg
# xwallpaper --zoom ~/.config/gallery/wall.jpg
