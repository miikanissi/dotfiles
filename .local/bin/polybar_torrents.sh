#!/bin/sh
# display number of torrents downloading, paused and seeding

torrents=$(transmission-remote -l)
downloading=$(echo "$torrents" | grep "Downloading\|Up & Down" | wc -l)
paused=$(echo "$torrents" | grep "Stopped" | wc -l)
seeding=$(echo "$torrents" | grep "Seeding" | wc -l)
idle=$(echo "$torrents" | grep "Idle" | wc -l)

echo "%{F#c85e7c}%{F-} $downloading %{F#c85e7c}%{F-} $seeding %{F#c85e7c}%{F-} $paused %{F#c85e7c}%{F-} $idle"
