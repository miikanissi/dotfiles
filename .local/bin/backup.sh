#!/bin/bash
mount_point=/media/miika/backup

if mountpoint -q -- $mount_point; then
  rsync -avxPW --delete-after --exclude '.local/share/Trash' --exclude '.cache' ~/ $mount_point
fi
