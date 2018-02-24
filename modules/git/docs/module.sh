#!/usr/bin/env bash

GIT_DATA_FILE=$TMP/git_data.yml

DATASOURCES[git]=file://$BUILD_HARNESS_PATH/modules/git/docs/templates/git.yml
DATASOURCES[git_data]=file://$GIT_DATA_FILE

function git_data-docs-prepare-data {
cat << EOF > $GIT_DATA_FILE
---
  url: $(git ls-remote --get-url)
  name: $(basename `git rev-parse --show-toplevel`)
EOF
}

function git_data-docs-cleanup-data {
  rm -f $GIT_DATA_FILE
}
