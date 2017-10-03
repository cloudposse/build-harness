TERRAFORM ?= terraform

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
	@FAIL=`$(TERRAFORM) fmt -write=false | xargs printf '\t- %s\n'`; \
	[ -z "$$FAIL" ] || (echo "Terraform configuration needs linting. Run '$(TERRAFORM) fmt'"; echo $$FAIL; exit 1)
