#!/bin/sh
# display number of torrents downloading, paused and seeding

if [ -z $(pidof transmission-daemon | awk '{print $1}') ]; then
  echo "%{T2}%{F#d381c3}%{F-}%{T-} 0 %{T2}%{F#d381c3}%{F-}%{T-} 0 %{T2}%{F#d381c3}%{F-}%{T-} 0 %{T2}%{F#d381c3}%{F-}%{T-} 0 "
else
  torrents=$(transmission-remote -l)
  downloading=$(echo "$torrents" | grep "Downloading\|Up & Down" | wc -l)
  paused=$(echo "$torrents" | grep "Stopped" | wc -l)
  seeding=$(echo "$torrents" | grep "Seeding" | wc -l)
  idle=$(echo "$torrents" | grep "Idle" | wc -l)

  echo "%{T2}%{F#d381c3}%{F-}%{T-} $downloading %{T2}%{F#d381c3}%{F-}%{T-} $seeding %{T2}%{F#d381c3}%{F-}%{T-} $paused %{T2}%{F#d381c3}%{F-}%{T-} $idle "
fi
