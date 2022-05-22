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
source ~/.vim/jrnl-prompt.sh 


alias bred="python ~/.vim/red.py"

function __git_branch_status() {
    branch=`git rev-parse --abbrev-ref HEAD`

    git for-each-ref --format='%(refname:short)' refs/heads | \
    while read local upstream; do

        # Use master if upstream branch is empty
        [ -z $upstream ] && upstream=dev

        ahead=`git rev-list dev..${local} --count`
        behind=`git rev-list ${local}..dev --count`

        if [[ $local == $branch ]]; then
            asterisk=*
        else
            asterisk=' '
        fi

        # Show asterisk before current branch
        echo -n "$asterisk $local"

        # Does this branch is ahead or behind upstream branch?
        if [[ $ahead -ne 0 && $behind -ne 0 ]]; then
            echo  -n $(bred --fg green " ($ahead ahead and $behind behind $upstream)")
        elif [[ $ahead -ne 0 ]]; then
            echo -n $(bred --fg green " ($ahead ahead $upstream)")
        elif [[ $behind -ne 0 ]]; then
            echo -n $(bred --fg green " ($behind behind $upstream)")
        fi

        # Newline
        echo

    done;
}

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

function __load_dot_env () {
    if [ -z "$*" ]; then
        if [ -f '.env' ]; then
            export $(cat .env | grep -v "#") && echo "loaded .env file"
            export DOTENV='.env'
        else
            $(echo "no .env file")
            unset DOTENV
        fi
    else
        if [ -f "$1" ]; then
            export $(cat "$1" | grep -v "#") && echo "loaded $1 file"
            export DOTENV=$1
        else
            echo "no .env file"
            unset DOTENV
        fi
    fi
}

function pyclean () {
        find . -regex '^.*\(__pycache__\|\.py[co]\)$' -delete
}

function venv () {
    bred "loading venv"
    if [ ! -d '.venv' ]; then
        python3 -m venv .venv
        echo "venv created"
    else
        . .venv/bin/activate
         echo "venv loaded"
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
    $POWERSHELL notebar -p 1739 
    $POWERSHELL notebar -p 1740 
    while true
    do
        (echo >/dev/tcp/localhost/4000) &>/dev/null && anybar green 1 || anybar red 1
        (echo >/dev/tcp/localhost/3000) &>/dev/null && anybar green  2 || anybar red 2
        sleep 1
    done
}

function __re_request(){
    gh pr edit --remove-reviewer alexghattas
    gh pr edit --add-reviewer alexghattas
    gh pr comment --body "@alexghattas changes were maded and  comments are done ..."

}

__git_stat() {
    git diff --stat dev..`git rev-parse --abbrev-ref HEAD`
}

__check_docker_run() {
    [ ! -f /var/run/docker.sock  ] && sudo service docker start
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
alias cdvistobackend="cd /home/zodman/visto/backend"
alias cdvistofrontend="cd /home/zodman/visto/frontend"
alias pr-open="gh  pr view --json url | jq .url | xargs wslview"
alias re-request="__re_request"
alias git-stat="__git_stat"
alias pg-test="docker run -p 127.0.0.1:5432:5432  --tmpfs=/data -e PGDATA=/data -e POSTGRES_PASSWORD=password postgres"
alias pg-test-log="pg-test -c log_statement=all"
alias python="python3"
alias git-branch-jira="python ~/.vim/jira_branch_info.py"
alias jira-list="python ~/.vim/jira_list.py"
alias git-branch-status=__git_branch_status
alias load-dot-env=__load_dot_env
