
###### NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

#### Docker for wsl taking from /etc/hosts
#export DOCKER_IP=127.0.0.1 
#$(getent  hosts host.docker.internal  | awk '{ print $1 }')
# export DOCKER_HOST=tcp://${DOCKER_IP}:2375
#export DOCKER_CERT_PATH=/mnt/c/Users/QA/.docker/machine/machines/default
#export DOCKER_TLS_VERIFY="1"
# sudo mount --bind /mnt/c /c

# export DISPLAY=:0
#export WINHOST=$(awk '/nameserver / {print $2; exit}' /etc/resolv.conf 2>/dev/null)
#export DISPLAY=$WINHOST:0
PGHOST="pglocalhost"

# sudo sed -i "/$PGHOST/ s/.*/$WINHOST\t$PGHOST/g" /etc/hosts


# adding directories to PATH
export PATH="/home/zodman/.yarn/bin:/home/zodman/.vim/bin:/home/zodman/.local/bin:$PATH"


POWERSHELL=/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe 

# virtualenvwrapper
FILE=/home/linuxbrew/.linuxbrew/bin/virtualenvwrapper.sh
if test -f "$FILE"; then
    source $FILE
fi


. "$HOME/.vim/alias.bash"


alias change-wallpaper="$POWERSHELL"' splash --query canada'
#echo "init jarvis ..." | lolcat -a 
#timeout 5 $POWERSHELL "mpv --really-quiet 'C:\Users\QA\jarvis\jbl_begin.caf'" 
# make shell like vi
set -o vi


export DOKKU_HOST=dokku

export EDITOR=nvim

# load .nvmrc https://stackoverflow.com/a/48322289/1003908
_nvmrc_hook() {
  if [[ $PWD == $PREV_PWD ]]; then
    return
  fi
  
  PREV_PWD=$PWD
  [[ -f ".nvmrc" ]] && nvm use
}

if ! [[ "${PROMPT_COMMAND:-}" =~ _nvmrc_hook ]]; then
  PROMPT_COMMAND="_nvmrc_hook${PROMPT_COMMAND:+;$PROMPT_COMMAND}"
fi
