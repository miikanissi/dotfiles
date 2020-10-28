#!/bin/bash

rsync -uvrP -e 'ssh -p 69' --delete-after ~/code/web/miikanissi.com/ root@miikanissi.com:/var/www/
