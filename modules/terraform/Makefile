TMP ?= /tmp
TERRAFORM ?= $(BUILD_HARNESS_PATH)/terraform
TERRAFORM_VERSION ?= 0.10.7
TERRAFORM_URL ?= https://releases.hashicorp.com/terraform/$(TERRAFORM_VERSION)/terraform_$(TERRAFORM_VERSION)_$(OS)_amd64.zip

TERRAFORM_DOCS_REPO ?= segmentio/terraform-docs
TERRAFORM_DOCS_VERSION ?= v0.3.0
TERRAFORM_DOCS = terraform-docs

## Install terraform
terraform\:install:
	@[ -x $(TERRAFORM) ] || ( \
		echo "Installing Terraform $(TERRAFORM_VERSION) ($(OS)) from $(TERRAFORM_URL)" && \
		curl '-#' -fL -o $(TMP)/terraform.zip $(TERRAFORM_URL) && \
		unzip -q -d $(TMP)/ $(TMP)/terraform.zip && \
		mv $(TMP)/terraform $(TERRAFORM) && \
		rm -f $(TMP)/terraform.zip \
		)
	$(TERRAFORM) version

## Install dependencies
terraform\:deps:
	@make github:download-public-release \
		REPO=$(TERRAFORM_DOCS_REPO) \
		FILE=$(TERRAFORM_DOCS)_$(OS)_amd64 \
		VERSION=$(TERRAFORM_DOCS_VERSION) \
		OUTPUT=/usr/local/bin/$(TERRAFORM_DOCS) > /dev/null
	@chmod +x /usr/local/bin/$(TERRAFORM_DOCS)

.PHONY : terraform\:docs
## Postprocess README.md by filling terraform module data
terraform\:docs:
	@$(eval TMP := $(shell date +'%Y%m%d-%H%M%S'))
	@$(TERRAFORM_DOCS) json . > /tmp/$(TMP).json
	@NAME='$(NAME)' \
		DESCRIPTION='$(DESCRIPTION)' \
		$(GOMPLATE) \
		--file ./README.md \
		--out  ./README.md \
		--datasource section=file://$(TEMPLATES)/sections.yml \
		--datasource license=file://$(TEMPLATES)/licenses.yml \
		--datasource contributor=file://$(TEMPLATES)/contributors.yml \
		--datasource terraform=file://$(TEMPLATES)/terraform.yml \
		--datasource terraform_data=file:///tmp/$(TMP).json
	@rm -f /tmp/$(TMP).json

## Ensure all plugins can be fetched
terraform\:get-plugins:
	@$(TERRAFORM) init -get-plugins -backend=false -input=false >/dev/null

## Ensure all modules can be fetched
terraform\:get-modules:
	@$(TERRAFORM) init -get -backend=false -input=false >/dev/null

## Basic terraform sanity check
terraform\:validate:
	@$(TERRAFORM) validate -check-variables=false

## Lint check Terraform
terraform\:lint:
	@FAIL=`$(TERRAFORM) fmt -write=false | xargs --no-run-if-empty -n 1 printf '\t- %s\n'`; \
	[ -z "$$FAIL" ] || (echo "Terraform configuration needs linting. Run '$(TERRAFORM) fmt'"; echo $$FAIL; exit 1)
