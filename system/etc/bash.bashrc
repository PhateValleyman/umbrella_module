# /etc/bash/bashrc
#
# This file is sourced by all *interactive* bash shells on startup,
# including some apparently interactive shells such as scp and rcp
# that can't tolerate any output.  So make sure this doesn't display
# anything or bad things will happen !

export HOME=/data/ssh/$USER
export HOSTNAME=$(getprop ro.lineage.device)
export TERM=xterm
export TMPDIR=/data/local/tmp
export USER=$(id -un)

# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]] ; then
	# Shell is non-interactive.  Be done now!
	return
fi

# Bash won't get SIGWINCH if another process is in the foreground.
# Enable checkwinsize so that bash will check the terminal size when
# it regains control.  #65623
# http://cnswww.cns.cwru.edu/~chet/bash/FAQ (E11)
shopt -s checkwinsize

# Enable history appending instead of overwriting.  #139609
shopt -s histappend

use_color=false

# enable colorful terminal
if [[ ${EUID} == 0 ]] ; then
	PS1='\[\033[01;31m\]${HOSTNAME:=$(hostname)}\[\033[01;34m\] \w \$\[\033[00m\] '
else
	PS1='\[\033[01;32m\]${USER:=$(id \-un)}@${HOSTNAME:=$(hostname)}\[\033[01;34m\] \w \$\[\033[00m\] '
fi

alias sysro='mount -o remount,ro /system'
alias sysrw='mount -o remount,rw /system'
alias lst='ls -1At --color=always'
alias ls='ls -1A --color=always'

# Try to keep environment pollution down, EPA loves us.
unset use_color safe_term match_lhs

alias '..'='cd ..'
alias '...'='.. && ..'
alias '....'='... && ..'
alias '.....'='.... && ..'
alias '......'='..... && ..'

export NANORC=/system/etc/nanorc

export HOME=/data/ssh/root
cd $HOME
