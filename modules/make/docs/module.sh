#!/usr/bin/env bash

DATASOURCES[make]=file://$BUILD_HARNESS_PATH/modules/make/docs/templates/make.yml
DATASOURCES[make_data]=file:///tmp/make_data.yml

function make_data-docs-prepare-data {
cat << EOF > /tmp/make_data.yml
---
help: |-
  $(make -s help | sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[mGK]//g" | sed -e 's/^/      /')
EOF
}

function make_data-docs-cleanup-data {
  rm -rf /tmp/make_data.yml
}
