# ~/.bashrc Miika Nissi
# https://miikanissi.com

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

# vim mode for bash
set -o vi

# prompt
export PS1='\[\e[0;36m\][\[\e[0;35m\]\u\[\e[0;36m\]@\[\e[0;35m\]\h\[\e[0;36m\]:\[\e[m\] \[\e[0;31m\]\W\[\e[0;36m\]]\[\e[0;35m\]$\[\e[m\] \[\e0'

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# navigation
alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'

# binds
bind -x '"\C-l":clear'
bind 'set bell-style none'

# color man pages
man() {
  env \
    LESS_TERMCAP_mb=$(printf "\e[1;31m") \
    LESS_TERMCAP_md=$(printf "\e[1;31m") \
    LESS_TERMCAP_me=$(printf "\e[0m") \
    LESS_TERMCAP_se=$(printf "\e[0m") \
    LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
    LESS_TERMCAP_ue=$(printf "\e[0m") \
    LESS_TERMCAP_us=$(printf "\e[1;32m") \
    man "$@"
  }

### aliases ###
# colors to commands
alias ll='ls --color=auto -laF'
alias ls='ls --color=auto --group-directories-first'
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
alias psg='\ps -e --forest | grep'
alias em='emacs -nw'
alias yt='youtube-dl'
alias yta='yt --extract-audio --audio-format mp3 --audio-quality 0'
alias rr='curl -s -L https://raw.githubusercontent.com/keroserene/rickrollrc/master/roll.sh | bash'
alias dotfiles='git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
alias pubip='dig +short myip.opendns.com @resolver1.opendns.com'
alias localip="ifconfig | grep -Eo 'inet (addr:)?([0-9]*\\.){3}[0-9]*' | grep -Eo '([0-9]*\\.){3}[0-9]*' | grep -v '127.0.0.1'"
alias pullall='find . -mindepth 1 -maxdepth 1 -type d -print -exec git -C {} pull \;'
alias odoo='/opt/odoo/12/server/odoo-bin'
alias odoo_run='odoo -c /opt/odoo/12/conf/odoo-12-all-dev-modules.conf'
alias mpg='cd /opt/odoo/12/addons/mpg-dev/'
alias passmenu='~/.local/bin/passmenu.sh'

# view markdown file in terminal via lynx
md () {
  pandoc $1 | lynx -stdin
}

### fzf
alias fe='~/.local/bin/fe.sh'
alias ff='~/.local/bin/ff.sh'
fd() {
  local dir
  dir=$(find ${1:-.} -type d 2> /dev/null | fzf +m) && cd "$dir"
}


# exports
export BROWSER=/usr/bin/firefox
export TERMINAL=/usr/bin/urxvt
export EDITOR=/usr/bin/vim
export LOCATION="Riihimäki"
export QT_QPA_PLATFORMTHEME=gtk2
export PATH=~/.local/bin:$PATH
export PATH=~/go/bin:$PATH
export FZF_DEFAULT_COMMAND='rg --files --no-ignore-vcs --hidden' # use ripgrep
export FZF_DEFAULT_OPTS="--layout=reverse --height=60% --preview-window=down:99%:wrap"
