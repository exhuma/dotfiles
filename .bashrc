# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

HISTCONTROL=ignoredups:ignorespace
shopt -s histappend
HISTSIZE=1000
HISTFILESIZE=2000
HISTTIMEFORMAT='%F %T '
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
GIT_BRANCH="\$(~/dotfiles/bin/gitbranch \"\[\e[0m\][\[\e[33;2m\]\" \"\[\e[0m\]] \")"
NUM_JOBS="\[\e[0m\](\j)"
if [ $(whoami) = "root" ]; then
    UCL="31;1"
    export PS1="${XTERM_TITLE}\[\e[${UCL}m\]┌\[\e[0m\] [\t] \[\e[${UCL}m\]\u\[\e[0m\]@\[\e[32;2m\]\H ${GIT_BRANCH}${NUM_JOBS}\n\[\e[${UCL}m\]└ \[\e[34;2m\]\W\[\e[32;2m\] \[\e[${UCL}m\]# \[\e[0m\]"
else
    UCL="34;1"
    export PS1="${XTERM_TITLE}\[\e[${UCL}m\]┌\[\e[0m\] [\t] \[\e[${UCL}m\]\u\[\e[0m\]@\[\e[32;2m\]\H ${GIT_BRANCH}${NUM_JOBS}\n\[\e[${UCL}m\]└ \[\e[34;2m\]\W\[\e[32;2m\] \[\e[${UCL}m\]$ \[\e[0m\]"
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

[ -x /usr/bin/vim ] && export EDITOR=vim
export PATH=~/bin:~/dotfiles/bin:/sbin:/usr/sbin:/usr/local/sbin:$PATH
export PYTHONSTARTUP=~/.pystartup

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# load host-specific configuration
if [ -f ${HOME}/.bashrc_`hostname -s` ]; then
   source ${HOME}/.bashrc_`hostname -s`
fi

# Change default sort order
export LC_COLLATE=C

# Enable vim input mode
set -o vi
bind -m vi-insert "\C-p":dynamic-complete-history
bind -m vi-insert "\C-n":menu-complete
bind -m vi-insert "\C-d":possible-completions
