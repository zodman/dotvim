# pip install http://bitbucket.org/sjl/t/get/tip.zip

#export TERM='xterm-256color'
TASKS_PATH='~/Dropbox/tasks'
alias t='t --task-dir ${TASKS_PATH} --list tasks'

#eval `keychain --eval --agents ssh id_rsa`
eval `keychain --agents ssh --eval id_rsa`
source $HOME/.keychain/$HOSTNAME-sh

