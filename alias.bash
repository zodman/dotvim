# pip install http://bitbucket.org/sjl/t/get/tip.zip

#export TERM='xterm-256color'
TASKS_PATH='~/Dropbox/tasks'
# pip install git+https://github.com/sjl/t.git

#eval `keychain --eval --agents ssh id_rsa`
eval `keychain --agents ssh --eval id_rsa`
eval `keychain --agents ssh --eval id_rsa2`
source $HOME/.keychain/$HOSTNAME-sh

source ~/.vim/docker_alias.bash


function _awsListAll() {

    credentialFileLocation=${AWS_SHARED_CREDENTIALS_FILE};
    if [ -z $credentialFileLocation ]; then
        credentialFileLocation=~/.aws/credentials
    fi

    while read line; do
        if [[ $line == "["* ]]; then echo "$line"; fi;
    done < $credentialFileLocation;
};

function _awsSwitchProfile() {
   if [ -z $1 ]; then  echo "Usage: awsp profilename"; return; fi
   
   exists="$(aws configure get aws_access_key_id --profile $1)"
   if [[ -n $exists ]]; then
       export AWS_DEFAULT_PROFILE=$1;
       export AWS_PROFILE=$1;
       export AWS_REGION=$(aws configure get region --profile $1);
       echo "Switched to AWS Profile: $1";
       aws configure list
   fi
};

function _ncduzip() {
    tmp_dir=$(mktemp -d -t ci-XXXXXXXXXX)
    du -hc $1
    7z x $1 -o$tmp_dir
    ncdu $tmp_dir
    rm $tmp_dir -rf
}

function gitpruneremote() {
    git remote prune origin
}
function gitprunelocal()  {
    git branch -r | awk '{print $1}' | egrep -v -f /dev/fd/0 <(git branch -vv | grep origin) | awk '{print $1}' | xargs git branch -d
}

function dubytype() {

    ftypes=$(find $1 -type f | grep -E ".*\.[a-zA-Z0-9]*$" | sed -e 's/.*\(\.[a-zA-Z0-9]*\)$/\1/' | sort | uniq)

    for ft in $ftypes
    do
            echo -n "$ft "
                # find $1 -name "*${ft}" -exec ls -l {} \; | awk '{total += $5} END {print total}'
                find $1 -name "*${ft}" -print0 | xargs -0 du -c | grep total | awk '{print $1}' 
            done
}

function rm-progress (){
    export $RES=$( du -a $1 | wc -l)
    rm $1 -rvf | pv -l -s $RES > /dev/null
    unset $RES
}

function c() {
  git commit -am "$*"
}

# https://github.com/zmwangx/ets
# https://github.com/sindresorhus/anybar-cli
function ___m() 
{
    anybar cyan
    eval "ets -s $@"; 
    if [ $? -eq 0 ]; then
        anybar green
        say -v Amelie Processus terminé
    else
        anybar red
        say -v Amelie Le processus a échoué
    fi
}

function gitignore() { curl -skL https://www.toptal.com/developers/gitignore/api/$@ ;}
function aws-echo-keys() {
    AWS_ACCESS_KEY_ID=`aws configure get aws_access_key_id`
    AWS_SECRET_ACCESS_KEY=`aws configure get aws_secret_access_key`
    AWS_REGION=`aws configure get region`
    echo "# AWS_PROFILE=${AWS_PROFILE}"
    echo "AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}"
    echo "AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}"
    echo "AWS_REGION=${AWS_REGION}"
}

function terminal-notifier(){
    $POWERSHELL "New-BurntToastNotification  -Silent -Text \"$1\", \"$2\""
}

function  clip-exe() {
    $POWERSHELL "clip.exe"
}

function edit-alias(){
    vim ~/.vim/alias.bash
    . ~/.vim/alias.bash
}
function load-dot-env () {
    if [ -z "$*" ]; then
        if [ -f '.env' ]; then
            export $(cat .env | grep -v "#") && red "loaded .env file"
            export DOTENV='.env'
        else
            red --fg yellow "no .env file"
            unset DOTENV
        fi
    else
        if [ -f "$1" ]; then
            export $(cat "$1" | grep -v "#") && red "loaded $1 file"
            export DOTENV=$1
        else
            red --fg yellow "no .env file"
            unset DOTENV
        fi
    fi
}

pyclean () {
        find . -regex '^.*\(__pycache__\|\.py[co]\)$' -delete
}

##### ALIAS
alias wttr='curl wttr.in -L'
alias wtc='git commit -am "$(curl --retry 5 --retry-delay 0 -s http://whatthecommit.com/index.txt)"'
alias awsall="_awsListAll"
alias awslist="_awsListAll"
alias awsset="_awsSwitchProfile"
alias awswho="aws configure list"
alias npm-cache-clear="npm cache clear --force"
alias husky-skip="HUSKY_SKIP_HOOKS=1"
alias ci-status='watch --color unbuffer "gh pr checks"'
alias p='git push --no-verify'
alias t='t --task-dir ${TASKS_PATH} --list tasks'
alias docker-stop-all='dstop'
alias view-path='echo "$PATH" | tr ":" "\n" | nl'
alias rscp='rsync -aP'
alias rsmv='rsync -aP --remove-source-files'
alias venv='python3 -m venv .venv'
alias venvact='source .venv/bin/activate'
# red from bake-cli
# export FZF_DEFAULT_COMMAND='fd --type f'

