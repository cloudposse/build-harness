#!/usr/bin/env bash

MAKE_DATA_FILE=$TMP/make_data.yml

DATASOURCES[make]=file://$BUILD_HARNESS_PATH/modules/make/docs/templates/make.yml
DATASOURCES[make_data]=file://$MAKE_DATA_FILE

function make_data-docs-prepare-data {
cat << EOF > $MAKE_DATA_FILE
---
help: |-
  $(make -s help | sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[mGK]//g" | sed -e 's/^/      /')
EOF
}

function make_data-docs-cleanup-data {
  rm -rf $MAKE_DATA_FILE
}
