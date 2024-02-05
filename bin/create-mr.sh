#!/bin/env bash
__create_pr() {
	BRANCH=$(git rev-parse --abbrev-ref HEAD | grep -oE '[A-Z]{2,9}-[0-9]{4}')
	TITLE=$(jira-issue $BRANCH | jq -r '.summary')
	KEY=$(jira-issue $BRANCH | jq -r '.key')
	LINK=$(jira-issue $BRANCH | jq -r '.link')
	SUMMARY=$(jira-issue $BRANCH | jq -r '.description')
	BODY=$(
		cat <<EOF
$TITLE
## Link to ticket: $LINK

## Brief description

$SUMMARY
EOF
	)
	BRANCH_TARGET=$(gum filter $(git for-each-ref --format="%(refname:short)" refs/heads/))
	glab mr create -a avargas101 --title "[$KEY] $TITLE" --description "$BODY" --draft --target-branch $BRANCH_TARGET -l $BRANCH_TARGET

}

__create_pr
