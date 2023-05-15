#!/bin/bash

# Usage:
# odtgrep.sh "Search Term" *.odt
# or
# find -name '*.odt' -exec odtgrep.sh IamSearchingThis "{}" \;

function odtgrep() {
	term="$1"
	shift 1
	for file in "$@"; do
		if unzip -p "$file" content.xml | tidy -q -xml 2>/dev/null | grep "$term" -q; then
			echo "${file}"
		fi
	done
}

odtgrep "$@"
