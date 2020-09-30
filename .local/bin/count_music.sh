#!/bin/sh
# counts the number of mp3, m4a, opus and flac files

flac=$(find ~/mus/ -iname *.flac | wc -l)
opus=$(find ~/mus/ -iname *.opus | wc -l)
mp3=$(find ~/mus/ -iname *.mp3 | wc -l)
m4a=$(find ~/mus/ -iname *.m4a | wc -l)

echo $(($flac+$opus+$mp3+$m4a))
