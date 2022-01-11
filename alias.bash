# pip install http://bitbucket.org/sjl/t/get/tip.zip

#export TERM='xterm-256color'
TASKS_PATH='~/Dropbox/tasks'
# pip install git+https://github.com/sjl/t.git

#eval `keychain --eval --agents ssh id_rsa`
eval `keychain --agents ssh --eval id_rsa`
eval `keychain --agents ssh --eval id_rsa2`
source $HOME/.keychain/$HOSTNAME-sh

source ~/.vim/docker_alias.bash
source ~/.vim/anybar_init.sh


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
       complete -C aws_completer aws
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
    ## du for a specify type

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

function c-n() {
    git commit --no-verify -am "$*"
}


function __c() {
    [ -d node_modules ] && npm run lint:fix
    git commit -am "$*"
}

# https://github.com/zmwangx/ets
# https://github.com/sindresorhus/anybar-cli
function ___m()
{
    anybar cyan
    eval "$@";
    if [ $? -eq 0 ]; then
        anybar green
    else
        anybar red
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
function aws-load-keys-profile() {
    export $(aws-echo-keys | grep -v '#' | xargs )
    env | grep AWS
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

function pyclean () {
        find . -regex '^.*\(__pycache__\|\.py[co]\)$' -delete
}

function venv () {
    red "loading venv"
    if [ ! -d '.venv' ]; then
        python3 -m venv .venv
        red "venv created"
    else
        . .venv/bin/activate
        red "venv loaded"
    fi
}

function nrlogs() {
    app=$1
    app_env=$2
    query_args="app='$app' and env='$app_env'"
    limit=$(tput lines)
    query="select message,app,env,levelname,lineno,pathname from Log where $query_args limit $limit"
    SPACE=" \" \""
    #cmd="newrelic  nrql query -q \"$query\" |  jq -r '.[] | (.levelname) + $SPACE  + (.timestamp|todate) + $SPACE + (.message) + $SPACE '"
    tail="jsonlog template --format \"{timestamp} [{app}] [{env}] {levelname} {pathname}:{lineno} {message}\""
    tail="fblog -p --main-line-format \"{{time}} {{app}} {{env}} {{levelname}} {{pathname}}:{{lineno}} {{message}}\""
    cmd="newrelic  nrql query -q \"$query\" | jq -c -r '.[]' | $tail"

    echo $cmd
    while true; do eval $cmd; sleep 1; done
}


function pvrm(){
    rm -frv $1 | pv -l -s $( du -a $1 | wc -l ) > /dev/null
}

function pr_status() {
    red "==== backend ====" && \
    gh pr list -R visto-tech/backend &&\
    gh pr status -R visto-tech/backend && \
    red "===== fronted ====" && \
    gh pr list -R visto-tech/frontend && \
    gh pr  status -R visto-tech/frontend
}

function check_anybar_running() {
    while true
    do
        (echo >/dev/tcp/localhost/4000) &>/dev/null && anybar green  || anybar red
        sleep 1
    done
}

##### ALIAS
alias m=anybar_monitor
alias wttr='curl wttr.in -L'
alias wtc='git commit -am "$(curl --retry 5 --retry-delay 0 -s http://whatthecommit.com/index.txt)"'
alias wtc-comment='gh pr comment -b "$(curl --retry 5 --retry-delay 0 -s http://whatthecommit.com/index.txt) \n plz review my changes"'
alias awsall="_awsListAll"
alias awslist="_awsListAll"
alias awsset="_awsSwitchProfile"
alias awswho="aws configure list"
alias npm-cache-clear="npm cache clear --force"
alias husky-skip="HUSKY_SKIP_HOOKS=1"
alias ci-status='m gh run watch --exit-status -i 1'
alias ci-log='gh run view --log-failed'
alias p='git push --no-verify'
alias t='t --task-dir ${TASKS_PATH} --list tasks'
alias docker-stop-all='dstop'
alias view-path='echo "$PATH" | tr ":" "\n" | nl'
alias rscp='rsync -aP'
alias rsmv='rsync -aP --remove-source-files'
alias m-ets="m ets -s"
alias cloudflare-docker-localhost="cloudflared tunnel --hostname localhost.python3.ninja --url http://$DOCKER_IP:3000"
alias poson="pg_ctl start -D /home/linuxbrew/.linuxbrew/var/postgres -l logfile"
alias posoff="pg_ctl  stop -D /home/linuxbrew/.linuxbrew/var/postgres -l logfile"
alias del-ts-check="ag '@ts-nocheck' -l | xargs sed -i  '/\/\/ @ts-nocheck/d'"
alias npm-completation="source <(npm completion)"
alias r=reset
alias pr-status=pr_status
alias explorer-here="$POWERSHELL explorer ."
alias vistoupdate="ncu -f /visto/ -u"
alias c-m="git commit --no-verify -m"
alias c=__c
alias reload-alias="source ~/.vim/alias.bash"
# red from bake-cli
# export FZF_DEFAULT_COMMAND='fd --type f'

