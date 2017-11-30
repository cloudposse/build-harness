#!/usr/bin/env bash

DATASOURCES[git]=file://$BUILD_HARNESS_PATH/modules/git/docs/templates/git.yml
DATASOURCES[git_data]=file:///tmp/git_data.yml

function git_data-docs-prepare-data {
cat << EOF > /tmp/git_data.yml
---
  url: $(git ls-remote --get-url)
  name: $(git ls-remote --get-url | grep -oP "(?<=\/).*(?=.git)")
EOF
}

function git_data-docs-cleanup-data {
  rm -rf /tmp/git_data.yml
}
