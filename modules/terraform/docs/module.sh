#!/usr/bin/env bash

TERRAFORM_DOCS_REPO=segmentio/terraform-docs
TERRAFORM_DOCS_VERSION=v0.3.0
TERRAFORM_DOCS=terraform-docs

DATASOURCES[terraform]=file://$BUILD_HARNESS_PATH/modules/terraform/docs/templates/terraform.yml
DATASOURCES[terraform_data]=file:///tmp/terraform_data.json


function terraform-docs-prepare-data {
  if [ ! -s /usr/local/bin/$TERRAFORM_DOCS ]; then
		REPO=$TERRAFORM_DOCS_REPO \
		  FILE=${TERRAFORM_DOCS}_${OS}_amd64 \
		  VERSION=$TERRAFORM_DOCS_VERSION \
		  OUTPUT=/usr/local/bin/$TERRAFORM_DOCS \
	      make github:download-public-release > /dev/null
	  chmod +x /usr/local/bin/$TERRAFORM_DOCS
	fi;
}

function terraform_data-docs-prepare-data {
  $TERRAFORM_DOCS json . > /tmp/terraform_data.json
}
function terraform-docs-cleanup-data {
  rm -rf /tmp/terraform_data.json
}

