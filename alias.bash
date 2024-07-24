export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
command -v pyenv >/dev/null || eval "$(pyenv init -)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

command -v glab -v >/dev/null || source $(glab completion -s bash)
command -v starship -V >/dev/null || eval "$(starship init bash)"
command -v direnv version >/dev/null && eval "$(direnv hook bash)"

[ -s "$HOME/.local/share/blesh/ble.sh" ] && source "$HOME/.local/share/blesh/ble.sh"
if [ -x "$(command -v podman)" ]; then
	export DOCKER_HOST="unix://$(podman info --format '{{.Host.RemoteSocket.Path}}')"
fi

# pip install http://bitbucket.org/sjl/t/get/tip.zip

#export TERM='xterm-256color'
TASKS_PATH='~/Dropbox/tasks'
# pip install git+https://github.com/sjl/t.git

# bw_add_sshkeys.py
eval $(keychain --eval --agents ssh id_rsa-nicoya)
eval $(keychain --eval --agents ssh id_rsa-digitalocean)

source ~/.vim/docker_alias.bash
source ~/.vim/nix_alias.sh
source ~/.vim/anybar_init.sh
source ~/.vim/jrnl-prompt.sh

if command -v gh &>/dev/null; then
	eval "$(gh completion -s bash)"
fi

export EDITOR='nvim'
export VISUAL=$EDITOR
set -o vi

_awsListAll() {

	credentialFileLocation=${AWS_SHARED_CREDENTIALS_FILE}
	if [ -z $credentialFileLocation ]; then
		credentialFileLocation=~/.aws/credentials
	fi

	while read line; do
		if [[ $line == "["* ]]; then echo "$line"; fi
	done <$credentialFileLocation
}

_awsSwitchProfile() {
	if [ -z $1 ]; then
		echo "Usage: awsp profilename"
		return
	fi

	exists="$(aws configure get aws_access_key_id --profile $1)"
	if [[ -n $exists ]]; then
		export AWS_DEFAULT_PROFILE=$1
		export AWS_PROFILE=$1
		export AWS_REGION=$(aws configure get region --profile $1)
		echo "Switched to AWS Profile: $1"
		aws configure list
		complete -C aws_completer aws
	fi

}

aws-echo-keys() {
	AWS_ACCESS_KEY_ID=$(aws configure get aws_access_key_id)
	AWS_SECRET_ACCESS_KEY=$(aws configure get aws_secret_access_key)
	AWS_REGION=$(aws configure get region)
	echo "# AWS_PROFILE=${AWS_PROFILE}"
	echo "AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}"
	echo "AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}"
	echo "AWS_REGION=${AWS_REGION}"
}
aws-load-keys-profile() {
	export $(aws-echo-keys | grep -v '#' | xargs)
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

	for ft in $ftypes; do
		echo -n "$ft "
		# find $1 -name "*${ft}" -exec ls -l {} \; | awk '{total += $5} END {print total}'
		find $1 -name "*${ft}" -print0 | xargs -0 du -c | grep total | awk '{print $1}'
	done
}

gitpruneremote() {
	git remote prune origin
}
gitprunelocal() {
	git branch -r | awk '{print $1}' | egrep -v -f /dev/fd/0 <(git branch -vv | grep origin) | awk '{print $1}' | xargs git branch -d
}
__git_branch_status() {
	branch=$(git rev-parse --abbrev-ref HEAD)

	git for-each-ref --format='%(refname:short)' refs/heads |
		while read local upstream; do

			# Use master if upstream branch is empty
			[ -z $upstream ] && upstream=dev

			ahead=$(git rev-list dev..${local} --count)
			behind=$(git rev-list ${local}..dev --count)

			if [[ $local == $branch ]]; then
				asterisk=*
			else
				asterisk=' '
			fi

			# Show asterisk before current branch
			echo -n "$asterisk $local"

			# Does this branch is ahead or behind upstream branch?
			if [[ $ahead -ne 0 && $behind -ne 0 ]]; then
				echo -n $(red --fg green " ($ahead ahead and $behind behind $upstream)")
			elif [[ $ahead -ne 0 ]]; then
				echo -n $(red --fg green " ($ahead ahead $upstream)")
			elif [[ $behind -ne 0 ]]; then
				echo -n $(red --fg green " ($behind behind $upstream)")
			fi

			# Newline
			echo

		done
}

__git_stat() {
	git diff --stat dev..$(git rev-parse --abbrev-ref HEAD)
}

__check_docker_run() {
	[ ! -f /var/run/docker.sock ] && sudo service docker start
}

__git_publish() {
	git push -u origin $(git rev-parse --abbrev-ref HEAD)
}

__check_code() {
	# -diff-filter=ACM ignore deleted https://stackoverflow.com/a/41730200/1003908
	declare gitfiles=$(git diff dev --name-only --diff-filter=ACM)
	red "files changed:"
	echo "$gitfiles"
	declare files=$(echo "$gitfiles" | grep ts)
	declare filesgql=$(echo "$gitfiles" | grep 'graphql\|prisma' | grep -v '\.sql\|\.dbml')
	test -n "$filesgql" && red "prettier ===" && npx prettier -w $filesgql
	if [ ! -z "$files" ]; then
		red "eslint ==="
		echo $files | xargs node_modules/.bin/eslint -c ./.eslintrc.zodman.js --fix --quiet --ext .ts --ext .tsx
		red "jscpd ==="
		echo $files | xargs npx -y jscpd -s
		red "complexity eslintcc ==="
		echo $files | xargs npx -y eslintcc -gt=B -sr
	fi
}

__c() {
	anybar blue
	if [ -d node_modules ]; then
		anybar cyan
		__check_code
		red "Checking code ==="
		git status
		anybar green
	fi
	git commit -am "$*" && anybar green || anybar red
}

gitignore() { curl -skL https://www.toptal.com/developers/gitignore/api/$@; }

rm-progress() {
	$RES=$(du -a $1 | wc -l)
	rm $1 -rvf | pv -l -s $RES >/dev/null
}

c-n() {
	git commit --no-verify -am "$*"
}

terminal-notifier() {
	$POWERSHELL "New-BurntToastNotification  -Silent -Text \"$1\", \"$2\""
}

clip-exe() {
	$POWERSHELL "clip.exe"
}

edit-alias() {
	nvim ~/.vim/alias.bash
	. ~/.vim/alias.bash
}

__load_dot_env() {
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

pyclean() {
	find . -regex '^.*\(__pycache__\|\.py[co]\)$' -delete
}

venv() {
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
	while true; do
		eval $cmd
		sleep 1
	done
}

pvrm() {
	rm -frv $1 | pv -l -s $(du -a $1 | wc -l) >/dev/null
}

srctodo() {
	rg -e '(TODO|FIX|HACK|BUG):' -t ts --vimgrep |
		awk '{split($1,arr,":"); print "\"git blame -f -n -L"  arr[2] "," arr[2], arr[1] "\""}' |
		xargs -n1 bash -c | rg "$(git config --global user.name)"
}

bw-search() {
	login=$(bw list items --search $1 | jq -r '.[] | {name: .name, username: .login.username, password: .login.password }')
	echo $login | jq
	password=$(echo "$login" | jq -r '.password')
	echo $password | pbcopy
	echo "copy to clipboard"
}

alto_qa_mongostat() {
	IP=$(get-ip-qa-alto)
	sshpass -p $ALTO_PASSWORD ssh -t $IP '~/.local/bin/tmuxp load /data/avargas/tmuxp_stat.yaml'
}

reload_nvm() {
	export NVM_DIR="$HOME/.nvm"
	[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
	[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion
}

get-ip-alto() {
	ALTO=$1
	list_alto_devices.py --json | grep $ALTO | jq -r .data.ip
}

alto-ros-status() {
	IP=$(get-ip-alto $1)
	curl -s http://$IP/server/system_scheduler/ss_get_node_state | jq -r '.node_state' | sed s/------------/\\n/g
}

print_status() {
	local message="$1"
	local status="$2"

	# Get the number of columns, but subtact 8 to leave space for the status.
	local columns=$((COLUMNS - 9))

	# Print left-aligned message and right-aligned status.
	printf "%-*s [%s] \n" "$columns" "$message" "$status"
}
is_ok() {
	print_status $1 $'\e[32m OK \e[m'
}
it_fail() {

	print_status $1 $'\e[31mFAILED\e[m'
}

##### ALIAS
[ "$TERM" = "xterm-kitty" ] && alias ssh="kitty +kitten  ssh"

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
alias t='t --task-dir ${TASKS_PATH} --list tasks'
alias docker-stop-all='dstop'
alias view-path='echo "$PATH" | tr ":" "\n" | nl'
alias rscp='rsync -aP'
alias rsmv='rsync -aP --remove-source-files'
alias m-ets="m ets -s"
alias cloudflare-docker-localhost="cloudflared tunnel --hostname localhost.python3.ninja --url http://$DOCKER_IP:3000"
alias del-ts-check="ag '@ts-nocheck' -l | xargs sed -i  '/\/\/ @ts-nocheck/d'"
alias npm-completation="source <(npm completion)"
alias r=reset
alias explorer-here="$POWERSHELL explorer ."
alias c=__c
alias reload-alias="source ~/.vim/alias.bash"
alias check-ts-code=__check_code
# red from bake-cli
# export FZF_DEFAULT_COMMAND='fd --type f'

alias pr-open="gh  pr view --json url | jq .url | xargs wslview"

alias git-stat="__git_stat"
alias git-pr-status=pr_status
alias git-branch-status=__git_branch_status
alias git-log="git log --all --decorate --oneline --graph"
alias git-publish=__git_publish
alias git-show-pr-visto=___visto_pr
alias git-select-branch='gum filter `git for-each-ref --format="%(refname:short)" refs/heads/`'
alias git-checkout='git checkout $(git-select-branch)'
alias git-create-pr=__create_pr
alias git-and-watch='git push && gum spin -- sleep 2  && gh run  watch && gum confirm "view logs" &&  gh run view --log'
alias push-ci='aic -a && git push && gum spin -- sleep 2  && glab ci view'
alias git-ready='glab mr update --ready && glab mr approve'
alias git-done='git-ready  &&  glab mr merge --auto-merge --squash -y'
alias pg-test="docker run -p 127.0.0.1:5432:5432  --tmpfs=/data -e PGDATA=/data -e POSTGRES_PASSWORD=password postgres"
alias pg-test-log="pg-test -c log_statement=all"
alias python="python3"
alias load-dot-env=__load_dot_env
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'
alias freememory='sudo gum spin --title="reseting memory" --show-output --  bash -c "echo 3 > /proc/sys/vm/drop_caches && sudo -S swapoff -a &&  sleep 2 && sudo -S swapon -a && service zram-config restart"'
alias please="gum input --password | sudo -nS"
alias git-j="bkt --ttl $(expr 5 \* 60 \* 1000)ms -- git-branch-jira"
alias list-alto-d="bkt --ttl $(expr 5 \* 60 \* 1000)ms -- list_alto_devices.py"
alias list-alto-devices="list_alto_devices.py"
alias ls='exa --group-directories-first'
alias now='date +"%FT%H%M"'
alias timeleft='termdown'
alias alto-up='tmuxp load ~/work/andres_tools/local.tmuxp.yaml'
alias alto-down='podman-compose -f ~/work/andres_tools/docker-compose.yaml down && tmux kill-session -t dev'
alias ssh-alto='sshpass -p $ALTO_PASSWORD ssh `ssh-alto-devices.sh`'
alias sshR='ssh -R 27017:localhost:27017'
alias get-ip-qa-alto='list_alto_devices.py  --json | grep ALTP0005 | jq -r .data.ip'
alias ssh-alto-qa='sshpass -p $ALTO_PASSWORD ssh `get-ip-qa-alto`'
alias s="gum spin --show-output --"
alias sync-ssh-keys='fab -r ~/work/andres_tools/   sync-ssh-keys -H'
alias find-larger-number-lines='find . -type f -print0 | xargs -0 wc -l | sort -n'
