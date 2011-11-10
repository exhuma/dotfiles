# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions

export PATH=/sbin:/usr/sbin:/usr/local/sbin:$PATH
export PYTHONSTARTUP=~/.pystartup

XTERM_TITLE="\[\e]2;\]\u@\H | \w\a\]"
if [ $(whoami) = "root" ]; then
    UCL="31;1"
    export PS1="${XTERM_TITLE}[\t] \[\e[${UCL}m\]\u\[\e[0m\]@\[\e[32;2m\]\H \[\e[34;2m\]\W\[\e[32;2m\] \[\e[0m\](\j) \[\e[${UCL}m\]# \[\e[0m\]"
else
    UCL="34;1"
    export PS1="${XTERM_TITLE}[\t] \[\e[${UCL}m\]\u\[\e[0m\]@\[\e[32;2m\]\H \[\e[34;2m\]\W\[\e[32;2m\] \[\e[0m\](\j) \[\e[${UCL}m\]$ \[\e[0m\]"
fi
