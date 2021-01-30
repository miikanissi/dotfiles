#!/bin/bash
mount_point=/mnt/sdb1

if mountpoint -q -- $mount_point; then
  sudo rsync -avxPW --delete-after \
    --exclude 'Music' \
    --exclude 'Pictures' \
    --exclude 'Videos' \
    --exclude 'Downloads' \
    --exclude 'go' \
    --include '.ssh' \
    --include '.gnupg' \
    --include '.password-store' \
    --exclude '.*' \
    /home/miika/ $mount_point/backup
fi
