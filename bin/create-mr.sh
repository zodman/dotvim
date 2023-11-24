#!/bin/env bash
__create_pr() {
	BRANCH=$(git rev-parse --abbrev-ref HEAD | grep -oE '[A-Z]{2,9}-[0-9]{4}')
	TITLE=$(jira-issue $BRANCH | jq '.summary')
	KEY=$(jira-issue $BRANCH | jq '.key')
	LINK=$(jira-issue $BRANCH | jq '.link')
	SUMMARY=$(jira-issue $BRANCH | jq '.description')
	BODY=$(
		cat <<EOF
$TITLE
## Link to ticket: $LINK

## Brief description

$SUMMARY
EOF
	)
	glab mr create --title "[$KEY] $TITLE" --description "$BODY" --draft
}

__create_pr
