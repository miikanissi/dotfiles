#!/bin/sh
# sends notification of current torrents in transmission

torrents="$(transmission-remote -l | sed '/Sum/d')"
notify-send "Torrents" "$(echo "$torrents" | sed '1d' | awk '{printf $2 " " $3 " " $4 " "}{for(i = 10; i < 30; i++) printf $i" "}{print ""}' | awk '{$1=$1};1')"

