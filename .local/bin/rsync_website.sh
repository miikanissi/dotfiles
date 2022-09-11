#!/bin/bash

rsync -uvrP -e 'ssh -p 69' --delete-after ~/Documents/Projects/miikanissi.com/public/ root@miikanissi.com:/var/www/www/
