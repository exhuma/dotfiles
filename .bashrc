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
NUM_JOBS="\j"
if [ $(whoami) = "root" ]; then
    UCL="31;1"
else
    UCL="34;1"
fi
export PS1="\[\e[${UCL}m\]\u@\h \w\[\e[0m\] ${NUM_JOBS}>\[\e[0m\] "

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

[ -x /usr/bin/vim ] && export EDITOR=vim
export PATH=~/bin:~/dotfiles/bin:/sbin:/usr/sbin:/usr/local/sbin:$PATH
export PYTHONSTARTUP=~/.pystartup
export GPGKEY=1CA23E80
export LC_COLLATE=C

#
# Bash completion for fabric
#
function _fab_complete() {
    local cur
    if [[ -f "fabfile.py" || -d "fabfile" ]]; then
        cur="${COMP_WORDS[COMP_CWORD]}"
        COMPREPLY=( $(compgen -W "$(fab -F short -l)" -- ${cur}) )
        return 0
    else
        # no fabfile.py found. Don't do anything.
        return 1
    fi
}

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
    complete -o nospace -F _fab_complete fab
fi

export TERM=xterm-256color
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias less='less -S'  # No word-wrap!
alias pyserv='python -m SimpleHTTPServer 5002' # Serve current folder on port 5002
alias tmux='TERM=xterm-256color tmux'
alias python='python -3 -Wd'

# load host-specific configuration
if [ -f ${HOME}/.bashrc_`hostname` ]; then
   source ${HOME}/.bashrc_`hostname`
fi

[ -f ~/.init_local ] && source ~/.init_local

# Change default sort order
export LC_COLLATE=C

# Enable vim input mode
set -o vi
bind -m vi-insert "\C-p":dynamic-complete-history
bind -m vi-insert "\C-n":menu-complete
bind -m vi-insert "\C-d":possible-completions

export JAVA_HOME=/usr/local/java/jdk1.7.0_09
export JRE_HOME=/usr/local/java/jre1.7.0_09
export PATH=$PATH:$JRE_HOME/bin:$JAVA_HOME/bin
export PATH=~/.local/bin:${PATH}
