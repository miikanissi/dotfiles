#!/bin/bash
# display number of torrents downloading, paused and seeding
color=$(xrdb -query | grep icon | awk '{print $2}')
if [ -z "$(pidof transmission-daemon | awk '{print $1}')" ]; then
	echo "%{T2}%{F$color}%{F-}%{T-} 0 %{T2}%{F$color}%{F-}%{T-} 0 %{T2}%{F$color}%{F-}%{T-} 0 %{T2}%{F$color}%{F-}%{T-} 0 "
else
	torrents=$(transmission-remote -l)
	downloading=$(echo "$torrents" | grep -c "Downloading\|Up & Down")
	paused=$(echo "$torrents" | grep -c "Stopped")
	seeding=$(echo "$torrents" | grep -c "Seeding")
	idle=$(echo "$torrents" | grep -c "Idle")

	echo "%{T2}%{F$color}%{F-}%{T-} $downloading %{T2}%{F$color}%{F-}%{T-} $seeding %{T2}%{F$color}%{F-}%{T-} $paused %{T2}%{F$color}%{F-}%{T-} $idle "
fi
