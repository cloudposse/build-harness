TMP ?= /tmp
TERRAFORM ?= $(BUILD_HARNESS_PATH)/vendor/terraform
TERRAFORM_VERSION ?= 1.0.11
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

## (Obsolete) Ensure all plugins can be fetched
terraform/get-plugins:
	@echo terraform -get-plugins no longer supported

## (Obsolete) Ensure all modules can be fetched
terraform/get-modules:
	@$(TERRAFORM) init -get -backend=false -input=false >/dev/null

## Basic terraform sanity check
terraform/validate:
	@$(TERRAFORM) validate

## Lint check Terraform
terraform/lint:
ifeq ($(OS), darwin)
	@FAIL=`$(TERRAFORM) fmt -write=false | xargs -n 1 printf '\t- %s\n'`; \
	[ -z "$$FAIL" ] || (echo "Terraform configuration needs linting. Run '$(TERRAFORM) fmt'"; echo $$FAIL; exit 1)
else
	@FAIL=`$(TERRAFORM) fmt -write=false | xargs --no-run-if-empty -n 1 printf '\t- %s\n'`; \
	[ -z "$$FAIL" ] || (echo "Terraform configuration needs linting. Run '$(TERRAFORM) fmt'"; echo $$FAIL; exit 1)
endif

terraform/fmt:
ifeq ($(wildcard *.tf),)
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

## Upgrade all terraform module sources
## This target has not been upgraded to handle registry format
terraform/upgrade-modules:
	@echo "* $@ has been disabled because it has not been updated to handle Terraform registry syntax"
	# @$(BUILD_HARNESS_PATH)/bin/upgrade_terraform_modules.sh all

# Rewrite the *.tf files to use registry notation for modules sources
terraform/rewrite-module-source: TERRAFORM = terraform-0.13
terraform/rewrite-module-source:
	@sed -i -E 's,\s*source\s+=\s+"git::https://github.com/([^/]+)/terraform-([^-]+)-(.+).git\?ref=(tags/)?([0-9.]+)",  source = "\1/\3/\2"\n  version     = "\5",g' $$(find . -type f -not -name context.tf -name '*.tf')
	@$(TERRAFORM) fmt .
	@$(TERRAFORM) fmt examples/complete

terraform/rewrite-readme-source: TERRAFORM = terraform-0.13
terraform/rewrite-readme-source:
	@sed -i -E 's,^(\s*)source\s+=\s+"git::https://github.com/([^/]+)/terraform-([^-]+)-(.+).git\?ref=(tags/)?master",\1source = "\2/\4/\3"\n\1# Cloud Posse recommends pinning every module to a specific version\n\1# version = "x.x.x",g' README.yaml

## Rewrite versions.tf to remove upper bound for terraform core version constraint (like this ">= 0.12.0, < 0.14.0")
## and convert "~>" constraints to ">=".
terraform/loosen-constraints: TERRAFORM = terraform-0.13
terraform/loosen-constraints:
	@for v in $$(find . -type f -name 'versions.tf'); do \
		DIR="$$(dirname $$v)"; \
		sed -i -E 's,\s\=\s*\"(.*[0-9.]+)(\,\s*<.*)", = "\1",g' "$$v" ; \
		sed -i -E 's,=\s*"\s*~>,= ">=,g' "$$v" ; \
		$(TERRAFORM) fmt "$$DIR" ; \
	done

## Rewrite versions.tf to bump modules with minimum core version of '0.12.x' to '>= 0.12.26'
terraform/bump-tf-12-min-version: TERRAFORM = terraform-0.13
terraform/bump-tf-12-min-version: terraform/loosen-constraints
	@for v in $$(find . -type f -name 'versions.tf'); do \
		DIR="$$(dirname $$v)"; \
		PIN="$$(terraform-config-inspect --json "$$DIR" | jq -r '.required_core[]')" ; \
		if vert "$$PIN" 0.12.25 >/dev/null; then \
			echo updating "$$v" ; \
			sed -i -E 's,required_version\s*\=\s*\"(\~>|>\=)\s?(0\.12(\.\d+)?)\",required_version = ">= 0.12.26",g' "$$v" ; \
			$(TERRAFORM) fmt $$DIR ; \
		else \
			echo "$$v" already pinned to "$$PIN" ; \
		fi; \
	done

## Rewrite versions.tf to update existing configuration to add an explicit source attribute for each provider
terraform/rewrite-required-providers: TERRAFORM = terraform-0.13
terraform/rewrite-required-providers: terraform/loosen-constraints
	@for v in $$(find . -type f -name 'versions.tf'); do \
		DIR="$$(dirname $$v)" ; \
		KEEP_VERSION=$$(grep -Eo 'required_version\s*=\s*"(.*)"' "$$v" | cut -d '"' -f2) ; \
		echo upgrading $$v ; \
		terraform-0.13 0.13upgrade -yes "$$DIR" >/dev/null ; \
		sed -i -E 's,(required_version\s*\=\s*\")(.*)(\"),\1'"$$KEEP_VERSION"'\3,g' "$$v" ; \
	done

terraform/v14-rewrite: TERRAFORM = terraform-0.13
terraform/v14-rewrite: terraform/loosen-constraints terraform/bump-tf-12-min-version terraform/rewrite-required-providers terraform/rewrite-module-source terraform/rewrite-readme-source
	@{ [[ "$(TERRAFORM_FORCE_README)" != "true" ]] && git diff --no-patch --exit-code README.yaml; } || $(MAKE) readme
