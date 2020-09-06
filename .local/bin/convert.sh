#!/bin/sh
#
# Converts all .HEIC files from a given directory into .jpg

DIR=$1
for file in $DIR/*.HEIC;
    do
        convert "${file}" -set filename:t '%d/%t-converted' '%[filename:t].jpg'
    done

