#!/bin/sh
# sets custom keyboard settings, run by udev
# create a file in /etc/udev/rules.d/99-keyboard.rules with
# ACTION=="bind", SUBSYSTEM=="usb", ENV{PRODUCT}=="4b4/510/201", RUN+="/bin/su m --command='/home/m/.local/bin/keyboard.sh'"
# replace m with your username and command with path to your command
# replace ENV{PRODUCT} with your product id

# we need to use X11 auth token for the calls otherwise xset and setckbmap won't work
export XAUTHORITY=/home/m/.Xauthority
export DISPLAY=:0

device_exists() {
    /usr/bin/xinput list --name-only | grep -Fq "$1"
}

# Wait 2 seconds to let keyboard / mouse register
sleep 2

# lock file
lock="/tmp/keyboard.lock"

# lock the file
exec 9>"$lock"
if ! flock -n 9; then
	# script already running
	exit 1
fi

# disable trackpad (it do be broken)
/usr/bin/xinput --disable "SynPS/2 Synaptics TouchPad"

# mouse acceleration off
/usr/bin/xset m 1 1

# mouse acceleration off and set DPI
if device_exists "Logitech MX518 Gaming Mouse"; then
    /usr/bin/xinput --set-prop "pointer:Logitech MX518 Gaming Mouse" "libinput Accel Profile Enabled" 0 1
    /usr/bin/xinput --set-prop "pointer:Logitech MX518 Gaming Mouse" "libinput Accel Speed" 0.5
fi
if device_exists "Logitech M720 Triathlon Multi-Device Mouse"; then
    /usr/bin/xinput --set-prop "pointer:Logitech M720 Triathlon Multi-Device Mouse" "libinput Accel Profile Enabled" 0 1
    /usr/bin/xinput --set-prop "pointer:Logitech M720 Triathlon Multi-Device Mouse" "libinput Accel Speed" 0.5
fi
if device_exists "TPPS/2 Elan TrackPoint"; then
    /usr/bin/xinput --set-prop "pointer:TPPS/2 Elan TrackPoint" "libinput Accel Profile Enabled" 0 1
    /usr/bin/xinput --set-prop "pointer:TPPS/2 Elan TrackPoint" "libinput Accel Speed" 0.3
fi

# makes key repeat faster
/usr/bin/xset r rate 200 80
# sets caps lock to ctrl and holding down right meta key toggles on finnish keyboard (for ä,ö,å)
/usr/bin/setxkbmap -option shift:both_shiftlock -option ctrl:nocaps -option grp:switch -option grp_led:scroll us,fi

# enable mousekeys
/usr/bin/xkbset m
# prevent mousekeys expiration
/usr/bin/xkbset exp =m
# remap print key to click
/usr/bin/xmodmap -e "keycode 135 = Pointer_Button1"

/usr/bin/xbindkeys -f /home/m/.config/xbindkeysrc

# lock file will be unlocked when the script ends
