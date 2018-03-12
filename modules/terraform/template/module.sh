#!/usr/bin/env bash

TERRAFORM_DOCS_REPO=segmentio/terraform-docs
TERRAFORM_DOCS_VERSION=v0.3.0
TERRAFORM_DOCS=${BUILD_HARNESS_PATH}/vendor/terraform-docs

TERRAFORM_DATA_FILE=$TMP/terraform_data.yml

DATASOURCES[terraform]=file://$BUILD_HARNESS_PATH/modules/terraform/template/terraform.yml
DATASOURCES[terraform_data]=file://$TERRAFORM_DATA_FILE

function terraform-template-prepare-data {
  if [ ! -s $TERRAFORM_DOCS ]; then
    make github/download-public-release \
      REPO=$TERRAFORM_DOCS_REPO \
      FILE=terraform-docs_${OS}_amd64 \
      VERSION=$TERRAFORM_DOCS_VERSION \
      OUTPUT=$TERRAFORM_DOCS

    chmod +x $TERRAFORM_DOCS
  fi;
}

function terraform_data-template-prepare-data {
  $TERRAFORM_DOCS json . > $TERRAFORM_DATA_FILE
}
function terraform-template-cleanup-data {
  rm -f $TERRAFORM_DATA_FILE
}

