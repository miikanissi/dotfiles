#!/bin/sh

STEP=20

case $1 in
    east)  dir=right; falldir=left;   sign=+;;
    west)  dir=right; falldir=left;   sign=-;;
    north) dir=top;   falldir=bottom; sign=-;;
    south) dir=top;   falldir=bottom; sign=+
esac

case $dir in
    right) x=$sign$STEP; y=0;;
    top)   y=$sign$STEP; x=0
esac

bspc node -z "$dir" "$x" "$y" || bspc node -z "$falldir" "$x" "$y"
