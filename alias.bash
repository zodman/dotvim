# pip install http://bitbucket.org/sjl/t/get/tip.zip

#export TERM='xterm-256color'
TASKS_PATH='~/Dropbox/tasks'
alias t='t --task-dir ${TASKS_PATH} --list tasks'

#eval `keychain --eval --agents ssh id_rsa`
eval `keychain --agents ssh --eval id_rsa`
source $HOME/.keychain/$HOSTNAME-sh

alias wtc='git commit -am "$(curl --retry 5 --retry-delay 0 -s http://whatthecommit.com/index.txt)"'

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
    7z x $1 -o$tmp_dir
    ncdu $tmp_dir
    rm $tmp_dir -rf
}

function gitprunelocal()  {
    git branch -r | awk '{print $1}' | egrep -v -f /dev/fd/0 <(git branch -vv | grep origin) | awk '{print $1}' | xargs git branch -d
}


alias awsall="_awsListAll"
alias awslist="_awsListAll"
alias awsset="_awsSwitchProfile"
alias awswho="aws configure list"
