
###### NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

#### Docker for wsl
export DOCKER_HOST=tcp://192.168.99.102:2376
export DOCKER_CERT_PATH=/mnt/c/Users/QA/.docker/machine/machines/default
export DOCKER_TLS_VERIFY="1"
sudo mount --bind /mnt/c /c

# export DISPLAY=:0


# export PATH=/home/zodman/.local/bin:/home/zodman/.local/bin:/home/zodman/.nvm/versions/node/v12.14.0/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/home/zodman/aws-glue-libs/bin:/home/zodman/aws-glue-libs/bin:

# brew for linux
eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)

# adding directories to PATH
export PATH="/home/linuxbrew/.linuxbrew/opt/python@3.8/bin:$PATH"
export PATH="/home/zodman/.yarn/bin:/home/zodman/.vim/bin:$PATH"



. "$HOME/.vim/alias.bash"
# powerline
powerline-daemon -q
POWERLINE_BASH_CONTINUATION=1
POWERLINE_BASH_SELECT=1
POWPATH=/home/linuxbrew/.linuxbrew/opt/python@3.8/lib/python3.8/site-packages/
. $POWPATH/powerline/bindings/bash/powerline.sh
# anybar
. ~/anybar-bash/init.sh
alias m=anybar_monitor

# WSL Shit
eval "$(gh completion -s bash)"
POWERSHELL=/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe 
alias change-wallpaper="$POWERSHELL"' splash --query canada'
echo "init jarvis ..." | lolcat -a 
timeout 5 $POWERSHELL "mpv --really-quiet 'C:\Users\QA\jarvis\jbl_begin.caf'" 
# make shell like vi
set -o vi

