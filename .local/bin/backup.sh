#!/bin/bash

rsync -uvrP --delete-after --exclude '.local/share/Trash' ~/ /media/miika/backup/
