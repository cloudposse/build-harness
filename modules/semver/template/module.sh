#!/usr/bin/env bash

SEMVER_FILE=$TMP/semver.yml

DATASOURCES[semver]=file://$SEMVER_FILE

function semver-template-prepare-data {
cat << EOF > $SEMVER_FILE
---
version: $SEMVERSION
EOF
}

function semver-template-cleanup-data {
  rm -f $SEMVER_FILE
}
