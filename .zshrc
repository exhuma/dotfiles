# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="robbyrussell"
ZSH_THEME="exhuma"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
DISABLE_AUTO_UPDATE="true"

# Uncomment to change how many often would you like to wait before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git cp debian lol vi-mode perhost)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
#export PATH=/home/users/michel//bin:/home/users/michel//dotfiles/bin:/sbin:/usr/sbin:/usr/local/sbin:/home/users/michel//bin:/home/users/michel//dotfiles/bin:/sbin:/usr/sbin:/usr/local/sbin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games
export PATH=~/bin:${PATH}
alias tmux='TERM=xterm-256color tmux'
alias less='less -S'  # No word-wrap!
export BROWSER=/usr/bin/firefox
export PYTHONSTARTUP=~/.pystartup
export PYTHONWARNINGS=default
export PSQL_EDITOR="/usr/bin/vim"

bindkey "^R" history-incremental-search-backward
bindkey $terminfo[khome] vi-beginning-of-line
bindkey $terminfo[kend] vi-end-of-line
bindkey "^[[3~" delete-char
bindkey -M vicmd "^k" up-history
bindkey -M viins "^k" up-history
bindkey -M vicmd "^j" down-history
bindkey -M viins "^j" down-history
bindkey -M viins "^q" push-line

unsetopt correct_all

DISABLE_AUTO_TITLE=true
