#!/bin/bash
# uses pacat for audio loopback

pacat -r --latency-msec=1 -d alsa_input.pci-0000_0c_00.4.analog-stereo | pacat -p --latency-msec=1 -d alsa_output.usb-FiiO_DigiHug_USB_Audio-01.analog-stereo &
