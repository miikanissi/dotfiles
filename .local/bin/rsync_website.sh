#!/bin/bash

rsync --archive --verbose --human-readable --partial --progress --compress --delete-after -e 'ssh -p 69' \
	~/Documents/miikanissi.com/public/ \
	root@miikanissi.com:/var/www/www/
