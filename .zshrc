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

autoload -U colors
colors

alias ls='ls --color=auto'
alias ll='ls -lAF'
alias l='ls -Fl'
alias grep='grep --color=auto'

if [ "`id -u`" -eq 0 ]; then
   export PS1="$(print '%{\e[1;31m%}%m%{\e[0m%}'):$(print '%{\e[1;34m%}%1~%{\e[0m%}')%# "
else
   export PS1="$(print '%{\e[1;32m%}%m%{\e[0m%}'):$(print '%{\e[1;34m%}%1~%{\e[0m%}')%# "
   #eval '/usr/bin/keychain --eval id_rsa'
fi

# source my personal and independent inits
. ${HOME}/.user_init

source ~/.zshrc_statec

