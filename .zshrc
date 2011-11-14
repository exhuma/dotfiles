# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt notify
unsetopt beep
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '~/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
umask 022

autoload -U colors
colors

alias ls='ls --color=auto'
alias ll='ls -lAF'
alias l='ls -Fl'
alias grep='grep --color=auto'

# if [ "`id -u`" -eq 0 ]; then
#    export PS1="$(print '%{\e[1;31m%}%m%{\e[0m%}'):$(print '%{\e[1;34m%}%1~%{\e[0m%}')%# "
# else
#    export PS1="$(print '%{\e[1;32m%}%m%{\e[0m%}'):$(print '%{\e[1;34m%}%1~%{\e[0m%}')%# "
#    #eval '/usr/bin/keychain --eval id_rsa'
# fi

JOBINFO="%1(j.(%j%).)"                        # Empty string if no bg-jobs, otherwise "(n)"
UCOLOR="%(!.%{${fg[red]}%}.%{${fg[green]}%})" # Red if running as root, green if non-root
NC="%{${fg[default]}%}"                       # Default Color
FCOLOR="%{${fg[blue]}%}"                      # Folder color
PS1="[${UCOLOR}%m${NC}:${FCOLOR}%1~${NC}]${JOBINFO}%# "
RPS1="${FCOLOR}%~${NC}"

export EDITOR=/usr/bin/vim

# source my personal and independent inits
if [ -f ${HOME}/.user_init ]; then
   source ${HOME}/.user_init
fi

if [ -f ${HOME}/.zshrc_`hostname` ]; then
   source ${HOME}/.zshrc_`hostname`
fi

rm ~/tmp/*
