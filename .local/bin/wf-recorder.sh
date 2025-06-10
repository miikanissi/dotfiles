#!/bin/bash

OUTPUT_DIR="$HOME/Videos/Screencaptures"
mkdir -p "$OUTPUT_DIR"

PID=$(pgrep -x wf-recorder)
if [ -n "$PID" ]; then
    kill "$PID"
    notify-send "wf-recorder:" "Recording stopped."
    exit 0
fi

FILENAME="$(date '+%Y-%m-%d_%H-%M-%S').mp4"
OUTPUT_PATH="$OUTPUT_DIR/$FILENAME"

REGION=$(slurp)
notify-send "wf-recorder" "Recording started in region: $REGION"

wf-recorder -g "$REGION" -f "$OUTPUT_PATH" & disown
