#!/bin/bash
# ~/.bashrc
# by Miika Nissi, https://miikanissi.com, https://github.com/miikanissi

# disable ctrl-s and ctrl-q
stty -ixon
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
PS1='\[\e[0;34m\][\[\e[0m\]\u\[\e[0;34m\]@\[\e[0m\]\h\[\e[0;34m\]: \[\e[0;1;31m\]\W\[\e[0;34m\]]\[\e[0m\]$ \[\e[0m\]'
# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

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
# others
alias psg='\ps -e --forest | grep' # grep for a running process
alias em='emacsclient -nw'
alias yt='youtube-dl --add-metadata -ic'
alias yta='yt --extract-audio --audio-format mp3 --audio-quality 0'
alias dotfiles='git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
alias pubip='dig +short myip.opendns.com @resolver1.opendns.com'
alias localip="ip address | grep -Eo 'inet (addr:)?([0-9]*\\.){3}[0-9]*' | grep -Eo '([0-9]*\\.){3}[0-9]*' | grep -v '127.0.0.1'"
alias pullall='find . -mindepth 1 -maxdepth 1 -type d -print -exec git -C {} pull \;' # gitpull all subdirectories
alias passmenu='~/.local/bin/rofi_passmenu.sh'                                        # replace passmenu script with rofi passmenu
alias v='~/Applications/nvim.appimage'
alias nvim='~/Applications/nvim.appimage'
alias docker='sudo docker'
alias wi='cd ~/Documents/odoo/16/addons/wildleaf'
alias wi14='cd ~/Documents/odoo/14/addons/wildleaf'
alias odoo='cd ~/Documents/odoo/16/odoo'
alias enterprise='cd ~/Documents/odoo/16/addons/enterprise'

branchall() {
	for i in */; do
		(cd $i && echo -n "${i}: " && git rev-parse --abbrev-ref HEAD)
	done
}

# view markdown file in terminal via lynx and pandoc
md() {
	pandoc "$1" | lynx -stdin
}
pyclean() {
	find . -type f -name '*.py[co]' -delete -o -type d -name __pycache__ -delete
}

### fzf
# Base16 Gruvbox light, medium
# Author: Dawid Kurek (dawikur@gmail.com), morhetz (https://github.com/morhetz/gruvbox)

_gen_fzf_default_opts() {

	local color00='#fbf1c7'
	local color01='#ebdbb2'
	local color02='#d5c4a1'
	local color03='#bdae93'
	local color04='#665c54'
	local color05='#504945'
	local color06='#3c3836'
	local color07='#282828'
	local color08='#9d0006'
	local color09='#af3a03'
	local color0A='#b57614'
	local color0B='#79740e'
	local color0C='#427b58'
	local color0D='#076678'
	local color0E='#8f3f71'
	local color0F='#d65d0e'

	export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS""\
 --color=bg+:$color01,bg:$color00,spinner:$color0C,hl:$color0D""\
 --color=fg:$color04,header:$color0D,info:$color0A,pointer:$color0C""\
 --color=marker:$color0C,fg+:$color06,prompt:$color0A,hl+:$color0D"

}

_gen_fzf_default_opts

alias fe='~/.local/bin/fe.sh'
alias ff='~/.local/bin/ff.sh'
fd() {
	local dir
	dir=$(find "${1:-.}" -type d 2>/dev/null | fzf +m) && cd "$dir" || exit
}

# exports
export BROWSER=/usr/bin/brave-browser
export TERMINAL="/usr/bin/kitty -1 --listen-on=tcp:localhost:12344"
export EDITOR=~/Applications/nvim.appimage
export LOCATION="Queens"
export QT_QPA_PLATFORMTHEME=gtk2
export PATH=~/.local/bin:$PATH
export PATH=~/.local/bin/statusbar:$PATH
export PATH=~/go/bin:$PATH
export PATH=~/node_modules/.bin:$PATH
export PATH=$PATH:/usr/local/go/bin
export FZF_DEFAULT_COMMAND='rg --files --no-ignore-vcs --hidden' # use ripgrep
export FZF_DEFAULT_OPTS="--layout=reverse --height=60% --preview-window=down:99%:wrap"
export SESSION_MANAGER=
cd ~/ || exit
