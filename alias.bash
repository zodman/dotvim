# pip install http://bitbucket.org/sjl/t/get/tip.zip

if [ -e /usr/share/terminfo/x/xterm-256color ]; then
    export TERM='xterm-256color'
else
    export TERM='xterm-color'
fi
alias t='t --task-dir ~/Dropbox/tasks --list tasks'

