#!/bin/sh

bspc query -T -d | jq -er '.layout == "monocle"' >/dev/null && bspc node -"$1" "$3" && exit 0
bspc node -"$1" "$2" && exit 0
