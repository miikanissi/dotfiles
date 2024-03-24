#!/bin/bash
# by Miika Nissi, https://miikanissi.com, https://github.com/miikanissi
# FZF search tool

usage() {
	printf "usage: ff [options]    edit selected file(s)\\n  --: Default fzf search\\n  -s: Search from file contents\\n  -i: Search with hidden files included\\n  -m: Search with multiline option\\n  -f <FILETYPE>: Limit search to a specified filetype\\n  -h: Show help message\\n"
}

while getopts "simf:h" o; do case "${o}" in
	h) usage && exit 1 ;;
	s) search="1" ;;
	i) hidden="1" ;;
	m) multiline="1" ;;
	f) filetype=${OPTARG} ;;
	*) printf "Invalid option: -%s\\n  -h: To show help\\n" "$OPTARG" && exit 1 ;;
	esac done

RG_DEFAULT_COMMAND="rg --no-messages --ignore-case"

[[ -n $filetype ]] && RG_DEFAULT_COMMAND+=" --type=$filetype"
[[ -n $hidden ]] && RG_DEFAULT_COMMAND+=" --hidden"
[[ -n $multiline ]] && RG_DEFAULT_COMMAND+=" --multiline --multiline-dotall"

if [[ -n $search ]]; then
	files=$(
		FZF_DEFAULT_COMMAND="$RG_DEFAULT_COMMAND --files" fzf \
			-m \
			--ansi \
			--phony \
			--reverse \
			--bind "ctrl-a:select-all" \
			--bind "f12:execute-silent:(subl -b {})" \
			--bind "change:reload:$RG_DEFAULT_COMMAND -l {q} || true" \
			--preview "rg -i --pretty --before-context 4 --after-context 12 {q} {}" | cut -d":" -f1,2
	)
else
	files=$(
		FZF_DEFAULT_COMMAND="$RG_DEFAULT_COMMAND --files" fzf \
			-m
	)
fi

[[ -n $files ]] && ${EDITOR:-vi} "$files"
