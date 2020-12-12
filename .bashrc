# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

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

PS1='\[\e[0;36m\][\[\e[0;35m\]\u\[\e[0;36m\]@\[\e[0;35m\]\h\[\e[0;36m\]:\[\e[m\] \[\e[0;31m\]\W\[\e[0;36m\]]\[\e[0;35m\]$\[\e[m\] \[\e0'

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Aliases
alias ll='ls --color=auto -laF'
alias ls='ls --color=always'
alias la='ls --color=auto -A'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias diff='diff --color=auto'
alias cp='cp -i'
alias df='df -h'
alias em='emacs -nw'
alias yt='youtube-dl'
alias yta='yt --extract-audio --audio-format mp3 --audio-quality 0'
alias rr='curl -s -L https://raw.githubusercontent.com/keroserene/rickrollrc/master/roll.sh | bash'
alias dotfiles='git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'

# make markdown into pdf
mdtopdf () {
  pandoc -t beamer -o $1 $2
}

# view markdown file in terminal
rmd () {
  pandoc $1 | lynx -stdin
}

# Exports
export BROWSER=/usr/bin/brave
export TERMINAL=/usr/bin/urxvt
export EDITOR=/usr/bin/vim
export QT_QPA_PLATFORMTHEME=gtk2
export PATH=/home/miika/.local/bin:$PATH
# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
