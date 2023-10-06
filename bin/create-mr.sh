#!/bin/env bash
__create_pr() {
	BRANCH=$(git rev-parse --abbrev-ref HEAD | grep -oE '[A-Z]{2,9}-[0-9]{4}')
	TITLE=$(jira-list -t | grep $BRANCH)
	LINK=$(jira-list -l | grep $BRANCH)
	SUMMARY=$(jira-list -s $BRANCH)
	BODY=$(
		cat <<EOF
$TITLE

## Link to ticket: $LINK

## Brief Description
#
$SUMMARY
EOF
	)
	glab mr create --title "$TITLE" --description "$BODY" --draft
}

__create_pr
