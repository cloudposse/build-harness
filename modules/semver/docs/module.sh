#!/usr/bin/env bash

SEMVER_FILE=$TMP/semver.yml

DATASOURCES[semver]=file://$SEMVER_FILE

function semver-docs-prepare-data {
cat << EOF > $SEMVER_FILE
---
version: $SEMVERSION
EOF
}

function semver-docs-cleanup-data {
  rm -f $SEMVER_FILE
}
