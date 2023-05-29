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


if  command -v gh &> /dev/null
then
    eval "$(gh completion -s bash)"
fi


_awsListAll() {

    credentialFileLocation=${AWS_SHARED_CREDENTIALS_FILE};
    if [ -z $credentialFileLocation ]; then
        credentialFileLocation=~/.aws/credentials
    fi

    while read line; do
        if [[ $line == "["* ]]; then echo "$line"; fi;
    done < $credentialFileLocation;
};

_awsSwitchProfile() {
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

aws-echo-keys() {
    AWS_ACCESS_KEY_ID=`aws configure get aws_access_key_id`
    AWS_SECRET_ACCESS_KEY=`aws configure get aws_secret_access_key`
    AWS_REGION=`aws configure get region`
    echo "# AWS_PROFILE=${AWS_PROFILE}"
    echo "AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}"
    echo "AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}"
    echo "AWS_REGION=${AWS_REGION}"
}
aws-load-keys-profile() {
    export $(aws-echo-keys | grep -v '#' | xargs )
    env | grep AWS
}


_ncduzip() {
    tmp_dir=$(mktemp -d -t ci-XXXXXXXXXX)
    du -hc $1
    7z x $1 -o$tmp_dir
    ncdu $tmp_dir
    rm $tmp_dir -rf
}
dubytype() {
    ## du for a specify type

    ftypes=$(find $1 -type f | grep -E ".*\.[a-zA-Z0-9]*$" | sed -e 's/.*\(\.[a-zA-Z0-9]*\)$/\1/' | sort | uniq)

    for ft in $ftypes
    do
            echo -n "$ft "
                # find $1 -name "*${ft}" -exec ls -l {} \; | awk '{total += $5} END {print total}'
                find $1 -name "*${ft}" -print0 | xargs -0 du -c | grep total | awk '{print $1}'
            done
}


gitpruneremote() {
    git remote prune origin
}
gitprunelocal()  {
    git branch -r | awk '{print $1}' | egrep -v -f /dev/fd/0 <(git branch -vv | grep origin) | awk '{print $1}' | xargs git branch -d
}
__git_branch_status() {
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
            echo  -n $(red --fg green " ($ahead ahead and $behind behind $upstream)")
        elif [[ $ahead -ne 0 ]]; then
            echo -n $(red --fg green " ($ahead ahead $upstream)")
        elif [[ $behind -ne 0 ]]; then
            echo -n $(red --fg green " ($behind behind $upstream)")
        fi

        # Newline
        echo

    done;
}

__git_stat() {
    git diff --stat dev..`git rev-parse --abbrev-ref HEAD`
}

__check_docker_run() {
    [ ! -f /var/run/docker.sock  ] && sudo service docker start
}

__git_publish () {
    git push  -u origin `git rev-parse --abbrev-ref HEAD`
}


__check_code (){
    # -diff-filter=ACM ignore deleted https://stackoverflow.com/a/41730200/1003908
    declare gitfiles=$(git diff dev --name-only --diff-filter=ACM)
    red "files changed:"
    echo "$gitfiles"
    declare files=$( echo "$gitfiles" | grep ts) 
    declare filesgql=$(echo "$gitfiles"| grep 'graphql\|prisma'| grep -v '\.sql\|\.dbml')
    test -n "$filesgql" && red "prettier ===" &&  npx prettier -w $filesgql
    if [ ! -z "$files" ]
    then
        red "eslint ==="
        echo $files | xargs node_modules/.bin/eslint  -c ./.eslintrc.zodman.js --fix --quiet --ext .ts --ext .tsx
        red "jscpd ==="
        echo $files | xargs npx -y jscpd -s
        red "complexity eslintcc ==="
        echo $files | xargs npx -y eslintcc  -gt=B  -sr
    fi
}


__c() {
    anybar blue
    if [ -d node_modules ] ;
    then
        anybar cyan
        __check_code
        red "Checking code ==="
        git status
        anybar green
    fi
    git commit -am "$*"  && anybar green || anybar red
}

gitignore() { curl -skL https://www.toptal.com/developers/gitignore/api/$@ ;}



rm-progress (){
    $RES=$( du -a $1 | wc -l)
    rm $1 -rvf | pv -l -s $RES > /dev/null
}

c-n() {
    git commit --no-verify -am "$*"
}

terminal-notifier(){
    $POWERSHELL "New-BurntToastNotification  -Silent -Text \"$1\", \"$2\""
}

clip-exe() {
    $POWERSHELL "clip.exe"
}

edit-alias(){

    nvim ~/.vim/alias.bash
    . ~/.vim/alias.bash
}

__load_dot_env () {
    if [ -z "$*" ]; then
        if [ -f '.env' ]; then
            export $(cat .env | grep -v "#") && red "loaded .env file"
            export DOTENV='.env'
        else
            red "no .env file"
            unset DOTENV
        fi
    else
        if [ -f "$1" ]; then
            export $(cat "$1" | grep -v "#") && red "loaded $1 file"
            export DOTENV=$1
        else
            red "no .env file"
            unset DOTENV
        fi
    fi
}

pyclean () {
        find . -regex '^.*\(__pycache__\|\.py[co]\)$' -delete
}

venv () {
    red "loading venv"
    if [ ! -d '.venv' ]; then
        python3 -m venv .venv
        . .venv/bin/activate
        red "venv created and loaded"

    else
        . .venv/bin/activate
         red "venv loaded"
    fi
}

nrlogs() {
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


pvrm(){
    rm -frv $1 | pv -l -s $( du -a $1 | wc -l ) > /dev/null
}

pr_status() {
    red "==== backend ====" && \
    gh pr list -R visto-tech/backend &&\
    gh pr status -R visto-tech/backend && \
    red "===== fronted ====" && \
    gh pr list -R visto-tech/frontend && \
    gh pr  status -R visto-tech/frontend
}


__re_request(){
    gh pr edit --remove-reviewer alexghattas
    gh pr edit --add-reviewer alexghattas
    gh pr comment --body "@alexghattas The changes have been made and comments are done ..."

}

___visto_pr () {
    red "For your review: :reviewed:"
    red backend
    cd ~/visto/backend
    BRANCH=$(git rev-parse --abbrev-ref HEAD)
    jira-list -t | grep $BRANCH
    echo `gh pr  view  --json url | jq -r ".url"`
    red --fg cyan "draft: `gh pr  view  --json isDraft | jq -r '.isDraft'`"
    git log @{u}..
    git log origin/$BRANCH..HEAD
    red frontend
    cd ~/visto/frontend
    BRANCH=$(git rev-parse --abbrev-ref HEAD)
    jira-list -t | grep $BRANCH
    echo `gh pr  view  --json url | jq -r ".url"` 
    red --fg cyan "draft: `gh pr  view  --json isDraft | jq -r '.isDraft'` "
    git log @{u}..
    git log origin/$BRANCH..HEAD
    git status -s
    red ":tv: VIDEO url: "

}

__create_pr (){
    BRANCH=$(git rev-parse --abbrev-ref HEAD)
    TITLE=$(jira-list -t | grep $BRANCH) 
    LINK=$(jira-list -l | grep $BRANCH) 
    SUMMARY=$(jira-list -s $BRANCH) 
    BODY=`cat <<EOF
## Link to ticket: $LINK

## Brief Description
$SUMMARY

## Screenshot(s) if applicable
EOF
`
    gh pr create -B dev --title "$TITLE" --body "$BODY"
}

git-sync-main-dev () {
    branch=$(git rev-parse --abbrev-ref HEAD)
    red "checkout main"
    git checkout main
    red '|--|'
    git pull
    red "checkout dev"
    git checkout dev
    git pull
    git merge main
    red '|--|'
    git checkout $branch
    git merge main
    git merge dev
    red done
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
alias ci-status='m gh run watch --exit-status -i 1'
alias ci-log='gh run view --log-failed'
alias p='git-sync-main-dev; git push'
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
alias git-pr-status=pr_status
alias explorer-here="$POWERSHELL explorer ."
alias vistoupdate="ncu -f /visto/ -u"
alias c=__c
alias reload-alias="source ~/.vim/alias.bash"
alias check-ts-code=__check_code
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
alias git-branch-status=__git_branch_status
alias load-dot-env=__load_dot_env
alias git-log="git log --all --decorate --oneline --graph"
alias git-publish=__git_publish
alias git-show-pr-visto=___visto_pr
alias git-create-pr=__create_pr
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'
alias freememory='sudo gum spin --title="reseting memory" --  bash -c "echo 3 > /proc/sys/vm/drop_caches && sudo -S swapoff -a &&  sleep 2 && sudo -S swapon -a"'
alias please="gum input --password | sudo -nS"
alias git-jira="git-branch-jira"
alias ls='exa --group-directories-first'
alias now='date +"%FT%H%M"'
alias timeleft='termdown'
alias git-and-watch='git push && gum spin -- sleep 2  && gh run  watch && gum confirm "view logs" &&  gh run view --log'
