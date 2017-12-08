#!/usr/bin/env bash

TERRAFORM_DOCS_REPO=segmentio/terraform-docs
TERRAFORM_DOCS_VERSION=v0.3.0
TERRAFORM_DOCS=${BUILD_HARNESS_PATH}/vendor/terraform-docs

TERRAFORM_DATA_FILE=$TMP/terraform_data.yml

DATASOURCES[terraform]=file://$BUILD_HARNESS_PATH/modules/terraform/docs/templates/terraform.yml
DATASOURCES[terraform_data]=file://$TERRAFORM_DATA_FILE


function terraform-docs-prepare-data {
  if [ ! -s $TERRAFORM_DOCS ]; then
    REPO=$TERRAFORM_DOCS_REPO \
    FILE=terraform-docs_${OS}_amd64 \
    VERSION=$TERRAFORM_DOCS_VERSION \
    OUTPUT=$TERRAFORM_DOCS \
    make github:download-public-release

    chmod +x $TERRAFORM_DOCS
  fi;
}

function terraform_data-docs-prepare-data {
  $TERRAFORM_DOCS json . > $TERRAFORM_DATA_FILE
}
function terraform-docs-cleanup-data {
  rm -f $TERRAFORM_DATA_FILE
}

