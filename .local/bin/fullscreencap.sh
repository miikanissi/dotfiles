#!/bin/sh

CUR_DATE=`date +"%m-%d-%Y_%I-%M%p"`

ffmpeg -video_size 1920x1080 -framerate 30 -f x11grab -i :0.0+0,0 vids/screencap/${CUR_DATE}.mp4

