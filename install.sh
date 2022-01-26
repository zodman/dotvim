#!/usr/bin/env bash
set -e 
ROOT_DIR=$(pwd)

echo "Installing & applying VIM config"
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

git clone https://github.com/gpakosz/.tmux.git ~/.tmux || echo bypass
ln -s -f ~/.tmux/.tmux.conf ~/.tmux.conf
ln -s -f ~/.vim/.tmux.conf.local ~/.tmux.conf.local

# sudo apt install tmux ack-grep python-pep8
ln -s ~/.vim/ctags ~/.ctagsrc || echo bypass
ln -s ~/.vim/ackrc ~/.ackrc || echo bypass
mkdir -p ~/.config/powerline
ln -s ~/.vim/powerline ~/.config/powerline || echo bypass
brew install ag universal-ctags powerline-go neovim \
    keychain gh python tmuxp nvm fzf jq
pip3 install pynvim


mkdir -p ~/.local/share/nvim/
ln -s -f  ~/.vim ~/.local/share/nvim/site
mkdir -p ~/.config/nvim/
ln -s -f  ~/.vim/vimrc  ~/.config/nvim/init.vim

#echo ". ~/.vim/profile_extended.sh" >> ~/.profile

