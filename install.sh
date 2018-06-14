#!/usr/bin/env bash
set -e 
ROOT_DIR=$(pwd)

echo "Installing & applying VIM config"
mkdir -p ~/.vim/bundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
# ~/.vim/bundle/neobundle.vim/bin/neoinstall
apt install tmux ack-grep python-pep8
