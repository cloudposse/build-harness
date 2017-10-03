TMP ?= /tmp
TERRAFORM ?= $(BUILD_HARNESS_PATH)/terraform
TERRAFORM_VERSION ?= 0.10.7
TERRAFORM_URL ?= https://releases.hashicorp.com/terraform/$(TERRAFORM_VERSION)/terraform_$(TERRAFORM_VERSION)_$(OS)_amd64.zip

## Install terraform
terraform\:install:
	$(call assert,TF_BIN_URL)
	@[ -x $(TERRAFORM) ] || ( \
		echo "Installing Terraform $(TERRAFORM_VERSION) ($(OS)) from $(TERRAFORM_URL)" && \
		curl '-#' -fL -o $(TMP)/terraform.zip $(TERRAFORM_URL) && \
		unzip -q -d $(TMP)/ $(TMP)/terraform.zip && \
		mv $(TMP)/terraform $(TERRAFORM) && \
		rm -f $(TMP)/terraform.zip \
		)
	$(TERRAFORM) version

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
