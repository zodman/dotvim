#!/usr/bin/env bash
set -e 
ROOT_DIR=$(pwd)

echo "Installing & applying VIM config"
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

sudo apt install tmux ack-grep python-pep8
ln -s ~/.vim/ctags ~/.ctagsrc || echo bypass
ln -s ~/.vim/ackrc ~/.ackrc || echo bypass
ln -s ~/.vim/powerline ~/.config/powerline || echo bypass
