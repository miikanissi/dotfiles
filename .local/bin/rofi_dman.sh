#!/bin/bash
# by Miika Nissi, https://miikanissi.com, https://github.com/miikanissi
# rofi/dmenu prompt to manage devices - dman

prompt="$(echo -e "mount\numount\neject\nlsblk" | rofi -dmenu -p "dman")"
if [ "$prompt" = mount ]; then
	dev="$(lsblk -lp | grep -E "/dev/.*part" | awk '{print $1}' | rofi -dmenu -p "mount")"
	[ -z "$dev" ] && exit 0
	devname=$(echo -n "$dev" | sed 's/\//\n/g' | tail -n 1)
	if ! mount | grep -q "$dev"; then
		if sudo cryptsetup isLuks "$dev"; then
			pass=$(rofi -dmenu -password -p "$dev passphrase")
			dir=$(find /mnt/ -mindepth 1 -maxdepth 1 | rofi -dmenu -p "$dev mountpoint")
			[[ -z $pass || -z $dir ]] && exit 0
			echo -n "$pass" | sudo cryptsetup luksOpen "$dev" "$devname" -d -
			sudo mount /dev/mapper/"$devname" "$dir"
			if mountpoint -q -- "$dir"; then
				notify-send "$dev mounted to $dir"
			else
				notify-send "Mount failed"
			fi
		else
			dir=$(find /mnt/ -mindepth 1 -maxdepth 1 | rofi -dmenu -p "$dev mountpoint")
			[ -z "$dir" ] && exit 0
			sudo mount "$dev" "$dir"
			if mountpoint -q -- "$dir"; then
				notify-send "$dev mounted to $dir"
			else
				notify-send "Mount failed"
			fi
		fi
	else
		notify-send "$dev is already mounted"
		exit 0
	fi
elif [ "$prompt" = umount ]; then
	dev=$(lsblk -lp | grep -E "/dev/.*part|/dev/.*crypt" | awk '{print $1}' | rofi -dmenu -p "umount")
	[ -z "$dev" ] && exit 0
	if ! mount | grep -q "$dev"; then
		notify-send "$dev is already unmounted"
		exit 0
	else
		sudo umount "$dev"
		if ! mount | grep -q "$dev"; then
			if ! echo "$dev" | grep -q "mapper"; then
				notify-send "$dev unmounted succesfully"
			else
				sudo cryptsetup luksClose "$dev"
				notify-send "$dev unmounted succesfully"
			fi
		else
			notify-send "Unmount failed"
		fi
	fi
elif [ "$prompt" = eject ]; then
	dev=$(lsblk -lp | grep -E "/dev/.*disk" | awk '{print $1}' | rofi -dmenu -p "eject")
	[ -z "$dev" ] && exit 0
	sudo eject "$dev"
	if ! lsblk -lp | grep -q "$dev"; then
		notify-send "$dev ejected succesfully"
	else
		notify-send "Eject failed"
	fi
elif [ "$prompt" = lsblk ]; then
	notify-send "$(lsblk -o NAME,SIZE,TYPE,MOUNTPOINT)"
fi
