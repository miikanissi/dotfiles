#!/bin/bash
mount_point=/media

if mountpoint -q -- $mount_point; then
  sudo rsync -avxPW --delete-after --exclude '.local/share/Trash' --exclude '.cache' /home/miika $mount_point/backup
fi
