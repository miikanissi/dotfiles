#!/bin/bash
mount_point=/mnt/usb

if mountpoint -q -- $mount_point; then
	sudo rsync -avhPWr --delete-after \
		/home/m/Applications \
		/home/m/Documents \
		/home/m/Mail \
		/home/m/Music \
		/home/m/Pictures \
		/home/m/Videos \
		/home/m/.ssh \
		/home/m/.gnupg \
		$mount_point/miika-backup
fi
