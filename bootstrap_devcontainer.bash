#!/bin/bash
set -xe
sudo apt update && sudo apt install -y \
    git \
    tig \
    tmux \
    tree \
    vim-nox \
    zsh

(cd && git clone https://github.com/exhuma/dotfiles)
exec ~/dotfiles/bootstrap_common
~/dotfiles/install -c
