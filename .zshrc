source /etc/profile

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
# ZSH_THEME="robbyrussell"
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
plugins=(git cp debian lol vi-mode perhost fabric tmux colored-man-pages colorize direnv fzf isodate oc)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH=~/bin:${PATH}
export PATH=~/.local/bin:${PATH}
export PATH=~/dotfiles/bin:${PATH}
export PATH=~/.local/opt/node-modules/bin:${PATH}
export PATH=~/.local/opt/pytools/bin:${PATH}
alias tmux='TERM=xterm-256color tmux'
alias less='less -S'  # No word-wrap!
alias pyserve='python3 -m http.server'
alias dps="docker ps --format 'table {{.Names}}\t{{.Status}}\t{{.Ports}}'"
alias pybump='git commit -m "Bump version to $(tomlq -r .project.version pyproject.toml)"'
alias jsbump='git commit -m "Bump version to $(jq -r .version package.json)"'
alias pytag='git tag -sm release v$(tomlq -r .project.version pyproject.toml)'
alias jstag='git tag -sm release v$(jq -r .version package.json)'
alias dps='docker ps --format '\''table {{.Names}}\t{{.Status}}\t{{.Ports}}'\'
alias xpsview='postcat -vq'
alias xpsrm='postsuper -d'


export BROWSER=/usr/bin/firefox
export PYTHONSTARTUP=~/.pystartup
export PYTHONWARNINGS=
export PSQL_EDITOR="/usr/bin/vim"
export EDITOR="/usr/bin/vim"
export GPGKEY=1CA23E80
export LC_COLLATE=C
export GOPATH=~/work/go
export PATH=${GOPATH}/bin:${PATH}
export PIPENV_VENV_IN_PROJECT="enabled"


bindkey "^R" history-incremental-search-backward
bindkey "^[[3~" delete-char
bindkey $terminfo[kend] vi-end-of-line
bindkey $terminfo[khome] vi-beginning-of-line
bindkey -M vicmd "^j" down-history
bindkey -M vicmd "^k" up-history
bindkey -M vicmd "v" edit-command-line
bindkey -M viins "^j" down-history
bindkey -M viins "^k" up-history
bindkey -M viins "^q" push-line

unsetopt correct_all
setopt nobeep

DISABLE_AUTO_TITLE=true

[ -f ~/.init_local ] && . ~/.init_local
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export PATH=~/.local/opt/node-modules/bin:${PATH}
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

