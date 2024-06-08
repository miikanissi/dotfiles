#!/bin/bash
# ~/.bashrc
# by Miika Nissi, https://miikanissi.com, https://github.com/miikanissi

# disable ctrl-s and ctrl-q
[[ $- == *i* ]] && stty -ixon
# enable bash completion in interactive shells
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
	. /etc/bash_completion
fi

# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth
# history size
HISTSIZE=10000
HISTFILESIZE=20000

# append to the history file, don't overwrite it
shopt -s histappend
# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize
# cd by just typing a dir name
shopt -s autocd
# vi mode in bash
set -o vi

# prompt
PS1='\[\e[34m\][\[\e[0m\]\u\[\e[34m\]@\[\e[0m\]\h\[\e[34m\]: \[\e[31;1m\]\w\[\e[0;34m\]]\[\e[0m\]\$ '
PROMPT_DIRTRIM=2
# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# binds
bind -x '"\C-l":clear'
bind 'set bell-style none'

# color man pages
man() {
	env \
		LESS_TERMCAP_mb="$(printf "\e[1;31m")" \
		LESS_TERMCAP_md="$(printf "\e[1;31m")" \
		LESS_TERMCAP_me="$(printf "\e[0m")" \
		LESS_TERMCAP_se="$(printf "\e[0m")" \
		LESS_TERMCAP_so="$(printf "\e[1;44;30m")" \
		LESS_TERMCAP_ue="$(printf "\e[0m")" \
		LESS_TERMCAP_us="$(printf "\e[1;32m")" \
		man "$@"
}

### aliases ###
# navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
# colors to commands
alias ll='ls --color=auto -lbAFhN'
alias ls='ls --color=auto --group-directories-first -hN'
alias la='ls --color=auto -A'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias diff='diff --color=auto'
# verbosity
alias cp='cp -vi'
alias mv='mv -vi'
alias rm='rm -v'
alias mkdir='mkdir -pv'
alias df='df -h'
# git
alias gps='git push'
alias gpl='git pull'
alias gc='git commit'
alias ga='git add'
alias gs='git status'
alias gd='git diff'
alias gl='git log --pretty="format:%C(yellow)%h %Cred%ar %Cblue%an%Cgreen%d %Creset%s" --graph --date=short'
alias dotfiles='git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
alias pullall='find . -mindepth 1 -maxdepth 1 -type d -print -exec git -C {} pull \;' # gitpull all subdirectories
# others
alias cat='batcat'
alias bat='batcat'
alias psg='\ps -e --forest | grep' # grep for a running process
alias em='emacsclient -nw'
alias yt='yt-dlp --add-metadata -ic'
alias yta='yt --extract-audio --audio-format mp3 --audio-quality 0'
alias pubip='dig +short myip.opendns.com @resolver1.opendns.com'
alias localip="ip address | grep -Eo 'inet (addr:)?([0-9]*\\.){3}[0-9]*' | grep -Eo '([0-9]*\\.){3}[0-9]*' | grep -v '127.0.0.1'"
alias v='nvim'
alias docker='sudo docker' # always run docker in sudo, cba with docker permissions
# personal shortcuts for often used dirs
alias odoo-addons='cd ~/Documents/odoo/addons'

branchall() {
	for i in */; do
		(cd "$i" && echo -n "${i}: " && git rev-parse --abbrev-ref HEAD)
	done
}

# Generate a pdf from markdown file
md2pdf() {
	pandoc -s --highlight-style=tango -V colorlinks=true -V linkcolor=blue -V urlcolor=red -V toccolor=gray -o "${1%.md}.pdf" "$1"
}
# view markdown file in terminal via lynx and pandoc
md() {
	pandoc "$1" | lynx -stdin
}
# delete all compiled python files
pyclean() {
	find . -type f -name '*.py[co]' -delete -o -type d -name __pycache__ -delete
}

# run fzf script
alias ff='~/.local/bin/ff.sh'
# run fzf for all non hidden dirs
fd() {
	local dir
	dir=$(find "${1:-.}" -type d -not -path '*/[@.]*' 2>/dev/null | fzf +m) && cd "$dir" || exit
}

# completion aliases
if [ -f "$HOME"/.local/bin/complete_alias ] && ! shopt -oq posix; then
	. "$HOME"/.local/bin/complete_alias

	complete -F _complete_alias gps
	complete -F _complete_alias gpl
	complete -F _complete_alias gc
	complete -F _complete_alias ga
	complete -F _complete_alias gs
	complete -F _complete_alias gd
	complete -F _complete_alias gl
	complete -F _complete_alias dotfiles
fi

# exports
export BROWSER=/usr/bin/brave-browser
export TERMINAL="/usr/bin/alacritty"
export EDITOR=/usr/bin/nvim
export ZK_NOTEBOOK_DIR=~/Documents/notes/
export LOCATION="Queens"
export QT_QPA_PLATFORMTHEME=gtk2
export PATH=~/.local/bin:$PATH
export PATH=~/.local/bin/statusbar:$PATH
export PATH=~/node_modules/.bin:$PATH
export PATH=$PATH:/usr/local/go/bin
export FZF_DEFAULT_COMMAND='rg --files' # use ripgrep with fzf
export FZF_DEFAULT_OPTS="--layout=reverse --height=60% --preview-window=down:99%:wrap"
export SESSION_MANAGER=
