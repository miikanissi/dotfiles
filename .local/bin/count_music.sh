#!/bin/sh
# counts the number of mp3, m4a, opus and flac files

mus_dir=$(xdg-user-dir MUSIC)
flac=$(find $mus_dir -iname *.flac | wc -l)
opus=$(find $mus_dir -iname *.opus | wc -l)
mp3=$(find $mus_dir -iname *.mp3 | wc -l)
m4a=$(find $mus_dir -iname *.m4a | wc -l)

echo $(($flac+$opus+$mp3+$m4a))
