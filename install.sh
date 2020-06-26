#!/usr/bin/env bash
set -e 
ROOT_DIR=$(pwd)

echo "Installing & applying VIM config"
mkdir -p ~/.vim/bundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim || echo " vundle installed"
# git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
# ~/.vim/bundle/neobundle.vim/bin/neoinstall
sudo apt install tmux ack-grep python-pep8
ln -s ~/.vim/ctags ~/.ctagsrc || echo bypass
ln -s ~/.vim/ackrc ~/.ackrc || echo bypass
ln -s ~/.vim/powerline ~/.config/powerline || echo bypass
vim +PluginInstall
