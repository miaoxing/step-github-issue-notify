#!/bin/bash

# Check if error file not empty
if [ -e "$WERCKER_GITHUB_ISSUE_ERROR_FILE" ]; then
    detail=$(cat "$WERCKER_GITHUB_ISSUE_ERROR_FILE")
else
    info "error file \"$WERCKER_GITHUB_ISSUE_ERROR_FILE\" not found"
    detail=""
fi

if [[ "$detail" = "" && "$WERCKER_RESULT" = "passed" ]]; then
  success "build passed"
  return 0
else
  info "build $WERCKER_RESULT"
fi

if [ ! -n "$WERCKER_GITHUB_ISSUE_NOTIFY_REPO" ]; then
  WERCKER_GITHUB_ISSUE_NOTIFY_REPO="$WERCKER_GIT_OWNER/$WERCKER_GIT_REPOSITORY"
fi
info "notify repo: $WERCKER_GITHUB_ISSUE_NOTIFY_REPO"

message=$(git log -1 --pretty=%B)
title="Build failed: $message"
assignee=$(git log -1 --pretty=%cn)
body="Status: $WERCKER_RESULT

Author: $assignee
Message: $title

"

if [ "$detail" != "" ]; then
    body+="Detail:
\`\`\`
$detail
\`\`\`
"
fi

if [ "$WERCKER_RESULT" != "passed" ]; then
    body+="Failed step: $WERCKER_FAILED_STEP_DISPLAY_NAME - $WERCKER_FAILED_STEP_MESSAGE"
fi

body+="

View the changeset: $WERCKER_GIT_OWNER/$WERCKER_GIT_REPOSITORY@$WERCKER_GIT_COMMIT

View the full build log and details: $WERCKER_RUN_URL"
body=${body//\'/\\\'}
body=${body//\"/\\\"}
body=${body//
/\\\n}

data="{\"title\": \"$title\",\"body\":\"$body\",\"assignees\":[\"$assignee\"],\"labels\": [\"task\"]}"
debug "$data"

curl -i -H "Authorization: token $WERCKER_GITHUB_ISSUE_NOTIFY_TOKEN" -d "$data" \
"https://api.github.com/repos/$WERCKER_GITHUB_ISSUE_NOTIFY_REPO/issues"
