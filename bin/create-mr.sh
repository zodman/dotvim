#!/bin/env bash
__create_pr() {

	BRANCH=$(git rev-parse --abbrev-ref HEAD | grep -oE '[A-Z]{2,9}-[0-9]{4}')
	TITLE=$(jira-issue $BRANCH | jq -r '.summary')
	KEY=$(jira-issue $BRANCH | jq -r '.key')
	LINK=$(jira-issue $BRANCH | jq -r '.link')
	SUMMARY=$(jira-issue $BRANCH | jq -r '.description')
	REPO_NAME=$(glab repo view -F json | jq -r '.name')
	BODY=$(
		cat <<EOF
$TITLE
## Link to ticket: $LINK

## Brief description

$SUMMARY
EOF
	)

	BRANCH_TARGET=$(git for-each-ref --format="%(refname:short)" \
		refs/heads/ | gum filter)
	glab mr create -a avargas101 --title "[$KEY] $TITLE" \
		--description "$BODY" --draft \
		--target-branch $BRANCH_TARGET -l $BRANCH_TARGET

	web_url=$(glab api merge_requests?source_branch=$BRANCH 2>/dev/null |
		jq -r '.[].web_url' | head -1)
	set -x
	jira-add-link "$BRANCH" "$web_url" "Gitlab MR on ${REPO_NAME}"
	set +x
}

__create_pr
