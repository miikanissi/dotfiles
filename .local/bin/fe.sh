#!/bin/sh
# by Miika Nissi, https://miikanissi.com, https://github.com/miikanissi
# fzf script to search for a file by name, filetype and/or content

while getopts ":s:f:h" o; do case "${o}" in
  h) printf "Optional arguments for custom use:\\n  -s <PATTERN>: Search term to look for in files\\n  -f <FILETYPE>: Limit search to a given filetype\\n  -h: Show this message\\n" && exit 1 ;;
  s) searchterm=${OPTARG} ;;
  f) filetype=${OPTARG} ;;
  *) printf "Invalid option: -%s\\n  -h: To show help\\n" "$OPTARG" && exit 1 ;;
esac done

# default ripgrep options to always run
opts='rg --no-messages --ignore-case --no-ignore-vcs --hidden'

if [ ! -z "$filetype" ]; then
  opts="$opts --type=$filetype"
fi
if [ ! -z "$searchterm" ]; then
  opts="$opts --files-with-matches $searchterm"
  files=$($opts | fzf --preview "highlight -O ansi -l {} 2> /dev/null | \
    rg --colors 'match:bg:yellow' --ignore-case --pretty --context 10 '$searchterm' || \
    rg --ignore-case --pretty --context 10 '$searchterm' {}")

  [[ -n "$files" ]] && ${EDITOR:-vim} "${files[@]}"
fi

opts="$opts --files"
files=$($opts | fzf --query="$1" --multi --select-1 --exit-0)

[[ -n "$files" ]] && ${EDITOR:-vim} "${files[@]}"
