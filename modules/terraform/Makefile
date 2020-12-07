TMP ?= /tmp
TERRAFORM ?= $(BUILD_HARNESS_PATH)/vendor/terraform
TERRAFORM_VERSION ?= 0.12.26
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
terraform/validate:
ifeq ("12","$(word 2, $(subst ., ,$(TERRAFORM_VERSION)))")
	@echo "Terraform 0.12 does not support validate without skipping variables"
else
	@$(TERRAFORM) validate -check-variables=false
endif

## Lint check Terraform
terraform/lint:
ifeq ($(OS), darwin)
	@FAIL=`$(TERRAFORM) fmt -write=false | xargs -n 1 printf '\t- %s\n'`; \
	[ -z "$$FAIL" ] || (echo "Terraform configuration needs linting. Run '$(TERRAFORM) fmt'"; echo $$FAIL; exit 1)
else
	@FAIL=`$(TERRAFORM) fmt -write=false | xargs --no-run-if-empty -n 1 printf '\t- %s\n'`; \
	[ -z "$$FAIL" ] || (echo "Terraform configuration needs linting. Run '$(TERRAFORM) fmt'"; echo $$FAIL; exit 1)
endif

## Upgrade all terraform module sources
terraform/upgrade-modules:
	@$(BUILD_HARNESS_PATH)/bin/upgrade_terraform_modules.sh all

## Rewrite the *.tf files to use registry notation for modules sources
terraform/rewrite-module-source:
	@sed -i -E 's,\s*source\s+=\s+"git::https://github.com/(.*?)/terraform-([^-]*?)-(.*?).git\?ref=(tags/)?(.*?)",  source = "\1/\3/\2"\n  version     = "\5",g' $$(find . -type f -not -name context.tf -name '*.tf')
	@$(TERRAFORM) fmt .
	@$(TERRAFORM) fmt examples/complete

terraform/rewrite-readme-source:
	@sed -i -E 's,^(\s*)source\s+=\s+"git::https://github.com/(.*?)/terraform-([^-]*?)-(.*?).git\?ref=(tags/)?master",\1source = "\2/\4/\3"\n\1# Cloud Posse recommends pinning module to a specific version\n\1# version     = "x.x.x",g' README.yaml

## Rewrite versions.tf to remove upper bound for terraform core version constraint (like this ">= 0.12.0, < 0.14.0")
terraform/remove-upper-bound:
	@sed -i -E 's,required_version\s*\=\s*\"(.*?)(\,\s*<.*)",required_version = "\1",g' $$(find . -type f -name 'versions.tf')
	@$(TERRAFORM) fmt .
	@$(TERRAFORM) fmt examples/complete

terraform/v14-rewrite: TERRAFORM = terraform-0.13
terraform/v14-rewrite: terraform/remove-upper-bound terraform/rewrite-module-source terraform/rewrite-readme-source
	git diff --no-patch --exit-code README.yaml || $(MAKE) readme
