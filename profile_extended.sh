
###### NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

#### Docker for wsl taking from /etc/hosts
export DOCKER_IP=127.0.0.1 
#$(getent  hosts host.docker.internal  | awk '{ print $1 }')
export DOCKER_HOST=tcp://${DOCKER_IP}:2375
#export DOCKER_CERT_PATH=/mnt/c/Users/QA/.docker/machine/machines/default
#export DOCKER_TLS_VERIFY="1"
# sudo mount --bind /mnt/c /c

# export DISPLAY=:0
export WINHOST=$(awk '/nameserver / {print $2; exit}' /etc/resolv.conf 2>/dev/null)
export DISPLAY=$WINHOST:0


# export PATH=/home/zodman/.local/bin:/home/zodman/.local/bin:/home/zodman/.nvm/versions/node/v12.14.0/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/home/zodman/aws-glue-libs/bin:/home/zodman/aws-glue-libs/bin:

# brew for linux
# eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)

# adding directories to PATH
export PATH="/home/linuxbrew/.linuxbrew/opt/python@3.8/bin:$PATH"
export PATH="/home/zodman/.yarn/bin:/home/zodman/.vim/bin:$PATH"


POWERSHELL=/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe 

# virtualenvwrapper
FILE=/home/linuxbrew/.linuxbrew/bin/virtualenvwrapper.sh
if test -f "$FILE"; then
    source $FILE
fi


. "$HOME/.vim/alias.bash"

# WSL Shit
eval "$(gh completion -s bash)"
alias change-wallpaper="$POWERSHELL"' splash --query canada'
#echo "init jarvis ..." | lolcat -a 
#timeout 5 $POWERSHELL "mpv --really-quiet 'C:\Users\QA\jarvis\jbl_begin.caf'" 
# make shell like vi
set -o vi

eval "$(gh completion -s bash)"

export DOKKU_HOST=dokku


