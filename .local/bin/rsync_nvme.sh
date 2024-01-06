#!/bin/bash
mount_point=/media/nvme

if mountpoint -q -- $mount_point; then
	sudo rsync -avxPW --delete-after \
		--exclude '.*' \
		--include '.ssh' \
		--include '.gnupg' \
		--include '.password-store' \
		/home/miika $mount_point/backup
fi
