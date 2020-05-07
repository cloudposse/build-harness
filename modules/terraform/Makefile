TMP ?= /tmp
TERRAFORM ?= $(BUILD_HARNESS_PATH)/vendor/terraform
TERRAFORM_VERSION ?= 0.11.11
TERRAFORM_URL ?= https://releases.hashicorp.com/terraform/$(TERRAFORM_VERSION)/terraform_$(TERRAFORM_VERSION)_$(OS)_$(BUILD_HARNESS_ARCH).zip

## Install terraform
terraform/install:
	@[ -x $(TERRAFORM) ] || ( \
		echo "Installing Terraform $(TERRAFORM_VERSION) ($(OS)) from $(TERRAFORM_URL)" && \
		curl '-#' -fL -o $(TMP)/terraform.zip $(TERRAFORM_URL) && \
		unzip -q -d $(TMP)/ $(TMP)/terraform.zip && \
		mv $(TMP)/terraform $(TERRAFORM) && \
		rm -f $(TMP)/terraform.zip \
		)
	$(TERRAFORM) version

## Ensure all plugins can be fetched
terraform/get-plugins:
	@$(TERRAFORM) init -get-plugins -backend=false -input=false >/dev/null

## Ensure all modules can be fetched
terraform/get-modules:
	@$(TERRAFORM) init -get -backend=false -input=false >/dev/null

## Basic terraform sanity check
## For v0.12.x, we supply a random region to AWS_DEFAULT_REGION so as to fix the
## "The argument "region" is required" error when validating independent modules.
## More info: https://github.com/hashicorp/terraform/issues/21408#issuecomment-495746582
terraform/validate: AWS_DEFAULT_REGION=us-west-2
terraform/validate:
ifeq ("12","$(word 2, $(subst ., ,$(TERRAFORM_VERSION)))")
	@$(TERRAFORM) validate
else
	@$(TERRAFORM) validate -check-variables=false
endif

## Lint check Terraform
terraform/lint:
	@FAIL=`$(TERRAFORM) fmt -write=false | xargs --no-run-if-empty -n 1 printf '\t- %s\n'`; \
	[ -z "$$FAIL" ] || (echo "Terraform configuration needs linting. Run '$(TERRAFORM) fmt'"; echo $$FAIL; exit 1)

## Upgrade all terraform module sources
terraform/upgrade-modules: packages/install/json2hcl
	@$(BUILD_HARNESS_PATH)/bin/upgrade_terraform_modules.sh all
