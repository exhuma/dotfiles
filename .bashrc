# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions

HISTCONTROL=ignoredups:ignorespace
shopt -s histappend
HISTSIZE=1000
HISTFILESIZE=2000
shopt -s checkwinsize
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

XTERM_TITLE="\[\e]2;\]\u@\H | \w\a\]"
if [ $(whoami) = "root" ]; then
    UCL="31;1"
    export PS1="${XTERM_TITLE}[\t] \[\e[${UCL}m\]\u\[\e[0m\]@\[\e[32;2m\]\H \[\e[34;2m\]\W\[\e[32;2m\] \[\e[0m\](\j) \[\e[${UCL}m\]# \[\e[0m\]"
else
    UCL="34;1"
    export PS1="${XTERM_TITLE}[\t] \[\e[${UCL}m\]\u\[\e[0m\]@\[\e[32;2m\]\H \[\e[34;2m\]\W\[\e[32;2m\] \[\e[0m\](\j) \[\e[${UCL}m\]$ \[\e[0m\]"
fi

[ -x /usr/bin/vim ] && export EDITOR=vim
export PATH=/sbin:/usr/sbin:/usr/local/sbin:$PATH
export PYTHONSTARTUP=~/.pystartup

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
