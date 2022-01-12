TMP ?= /tmp
TERRAFORM ?= $(BUILD_HARNESS_PATH)/vendor/terraform
TERRAFORM_VERSION ?= 1.0.11
TERRAFORM_URL ?= https://releases.hashicorp.com/terraform/$(TERRAFORM_VERSION)/terraform_$(TERRAFORM_VERSION)_$(OS)_$(BUILD_HARNESS_ARCH).zip
TERRAFORM_TFVARS ?= tfvars
TERRAFORM_INFRA_DIR ?= ./


## Install terraform
terraform/install:
	@[ -x $(TERRAFORM) ] || ( \
		echo "Installing Terraform $(TERRAFORM_VERSION) ($(OS)) from $(TERRAFORM_URL)" && \
		rm -rf $(TMP)/terraform* && \
		curl '-#' -fL -o $(TMP)/terraform.zip $(TERRAFORM_URL) && \
		unzip -q -d $(TMP)/ $(TMP)/terraform.zip && \
		mv $(TMP)/terraform $(TERRAFORM) && \
		rm -rf $(TMP)/terraform* \
		)
	$(TERRAFORM) version

## Ensure all modules can be fetched
terraform/get-modules:
	@$(TERRAFORM) -chdir=$(TERRAFORM_INFRA_DIR) init -get -backend=false -input=false >/dev/null

## Basic terraform sanity check
terraform/validate:
	@$(TERRAFORM) -chdir=$(TERRAFORM_INFRA_DIR) validate

## Lint check Terraform
terraform/lint:
ifeq ($(OS), darwin)
	@FAIL=`$(TERRAFORM) -chdir=$(TERRAFORM_INFRA_DIR) fmt -write=false | xargs -n 1 printf '\t- %s\n'`; \
	[ -z "$$FAIL" ] || (echo "Terraform configuration needs linting. Run '$(TERRAFORM) fmt'"; echo $$FAIL; exit 1)
else
	@FAIL=`$(TERRAFORM) -chdir=$(TERRAFORM_INFRA_DIR) fmt -write=false | xargs --no-run-if-empty -n 1 printf '\t- %s\n'`; \
	[ -z "$$FAIL" ] || (echo "Terraform configuration needs linting. Run '$(TERRAFORM) fmt'"; echo $$FAIL; exit 1)
endif

## Format Terraform
terraform/fmt:
ifeq ($(wildcard **/*.tf),)
	@echo "* $@: No terraform files detected"
else
	@{ command -v terraform-0.13 && \
	command -v terraform-0.14 && \
	command -v terraform-0.15 && \
	command -v terraform-1 \
	; } >/dev/null || { echo "* $@ requires binaries named terraform-0.13, terraform-0.14, terraform-0.15, and terraform-1" && false; }
	@ # vert exits non-zero if any of the versions are not acceptable, so `|| [[ -n "$VERSION" ]]` for a real error check
	@TF012=0.12.29; \
	TF013=$$(terraform-0.13 version --json | jq -r .terraform_version); \
	TF014=$$(terraform-0.14 version --json | jq -r .terraform_version); \
	TF015=$$(terraform-0.15 version --json | jq -r .terraform_version); \
	TF1=$$(terraform-1 version --json | jq -r .terraform_version); \
	VERSION=$$(vert -s "$$(terraform-config-inspect --json . | jq -r '.required_core[]')" "$$TF012" "$$TF013" "$$TF014" "$$TF015" "$$TF1" | head -1) || [[ -n "$$VERSION" ]]; \
	VERSION=$${VERSION:0:4}; \
	[[ $$VERSION =~ ^1 ]] && VERSION=1 || true; \
	terraform-$${VERSION} fmt -recursive .
endif
