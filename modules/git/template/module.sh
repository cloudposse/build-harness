#!/usr/bin/env bash

GIT_FILE=$TMP/git.yml

DATASOURCES[git]=file://$GIT_FILE

function git-template-prepare-data {
cat << EOF > $GIT_FILE
---
  url: $(git ls-remote --get-url)
  name: $(basename `git ls-remote --get-url` .git)
  commit: ${GIT_COMMIT}
  commit_short: ${GIT_COMMIT_SHORT}
  branch: ${GIT_BRANCH}
  latest_tag: ${LATEST_TAG}
  is_tag: ${GIT_IS_TAG}
  is_branch: ${GIT_IS_BRANCH}
EOF
}

function git-template-cleanup-data {
  rm -f $GIT_FILE
}
