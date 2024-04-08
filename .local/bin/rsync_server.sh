#!/bin/bash

rsync --archive --verbose --human-readable --partial --progress --relative --compress --delete-after -e 'ssh -p 69' \
	root@miikanissi.com:/./var/www/ \
	root@miikanissi.com:/./var/lib/docker/volumes \
	root@miikanissi.com:/./etc/nginx \
	~/Documents/server-backup/
