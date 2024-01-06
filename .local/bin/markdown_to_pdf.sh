#!/bin/bash
# uses pandoc and beamer to compile markdown into pdf

if [ -z "$1" ] || [ -z "$2" ]; then
	echo 'Usage:' \
		'markdown_to_pdf.sh outputfile inputfile'
	exit 0
fi

pandoc -t beamer -o "$1" "$2"
