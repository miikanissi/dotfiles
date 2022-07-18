#!/bin/bash

rsync -uvrP -e 'ssh -p 69' --delete-after ~/Work/Projects/miikanissi.com/public/ root@miikanissi.com:/var/www/www/
