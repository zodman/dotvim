#!/bin/env bash
BRANCH=$(echo $1 | grep -oE '[A-Z]{2,9}-[0-9]{4}')
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

glab mr update $1 --title "[$KEY] $TITLE" --description "$BODY"
