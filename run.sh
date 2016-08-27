#!/usr/bin/env bash

echo 'Build' $WERCKER_RESULT;

if [ $WERCKER_RESULT = 'passed' ] ; then
  return 0
fi

if [ ! -n "$WERCKER_GITHUB_ISSUE_NOTIFY_REPO" ]; then
  $WERCKER_GITHUB_ISSUE_NOTIFY_REPO="$WERCKER_GIT_OWNER/$WERCKER_GIT_REPOSITORY"
fi

title='Build failed: '$(git log -1 --pretty=%B)

assignee=$(git log -1 --pretty=%cn)

body="Result: $WERCKER_RESULT

Failed step: $WERCKER_FAILED_STEP_DISPLAY_NAME - $WERCKER_FAILED_STEP_MESSAGE

View changeset: $WERCKER_GIT_OWNER/$WERCKER_GIT_REPOSITORY@$WERCKER_GIT_COMMIT

View build log: $WERCKER_RUN_URL"
body=${body//\'/\\\'}
body=${body//\"/\\\"}
body=${body//
/\\\n}

data="{\"title\": \"$title\",\"body\":\"$body\",\"assignees\":[\"$assignee\"],\"labels\": [\"task\"]}"
echo $data

curl -i -H "Authorization: token $WERCKER_GITHUB_ISSUE_NOTIFY_TOKEN" -d "$data" \
https://api.github.com/repos/$WERCKER_GITHUB_ISSUE_NOTIFY_REPO/issues
