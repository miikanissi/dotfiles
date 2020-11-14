#!/bin/bash
mount_point=~/backup

if mountpoint -q -- $mount_point; then
  sudo rsync -avxPW --delete-after --exclude '.local/share/Trash' --exclude '.cache' --exclude 'backup' ~/ $mount_point/backup-arch
fi
