#!/bin/bash

rsync -avxP --delete-after --exclude '.local/share/Trash' --exclude '.cache' ~/ /media/miika/backup/
