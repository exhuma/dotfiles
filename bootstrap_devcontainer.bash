#!/bin/bash
set -xe
sudo apt update && sudo apt install -y \
    git \
    tig \
    tmux \
    tree \
    vim-nox \
    zsh

OLDPWD=$(pwd)
cd
if [ -d dotfiles ]; then
    (cd dotfiles && git pull)
else
    git clone https://github.com/exhuma/dotfiles
fi
~/dotfiles/bootstrap_common
~/dotfiles/install -c
cd ${OLDPWD}
