#!/bin/env bash
set -x
__create_pr() {
	PARENT_BRANCH=$(
		git show-branch -a 2>/dev/null |
			sed "s/].*//" |
			grep "\*" |
			grep -v "$(git rev-parse --abbrev-ref HEAD)" |
			head -n1 |
			sed "s/^.*\[//"
	)
	BRANCH=$(git rev-parse --abbrev-ref HEAD)
	JIRA_ID=$(echo $BRANCH | grep -oE '[A-Z]{2,9}-[0-9]{4}')
	TITLE=$(jira-issue $JIRA_ID | jq -r '.summary')
	KEY=$(jira-issue $JIRA_ID | jq -r '.key')
	LINK=$(jira-issue $JIRA_ID | jq -r '.link')
	SUMMARY=$(jira-issue $JIRA_ID | jq -r '.description')
	REPO_NAME=$(glab repo view -F json | jq -r '.name')
	BODY=$(
		cat <<EOF
$TITLE
## Link to ticket: $LINK

## Brief description

$SUMMARY
EOF
	)

	# BRANCH_TARGET=$PARENT_BRANCH
	BRANCH_TARGET=$(git for-each-ref --format="%(refname:short)" | gum filter)
	glab mr create -a avargas101 --title "[$KEY] $TITLE" \
		--description "$BODY" --draft \
		--target-branch $BRANCH_TARGET

	web_url=$(glab api merge_requests?source_branch=$BRANCH 2>/dev/null |
		jq -r '.[].web_url' | head -1)
	jira-add-link "$JIRA_ID" "$web_url" "Gitlab MR on ${REPO_NAME}"
}

__create_pr
