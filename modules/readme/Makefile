export README_LINT ?= $(TMP)/README.md
export README_FILE ?= README.md
export README_YAML ?= README.yaml

export README_TEMPLATE_REPO_REMOTE_NAME ?= origin
export README_TEMPLATE_REPO_REMOTE ?= $(shell git remote get-url $(README_TEMPLATE_REPO_REMOTE_NAME))

# Parse https://github.com/...
ifneq (,$(findstring https://,$(README_TEMPLATE_REPO_REMOTE)))
export README_TEMPLATE_REPO_ORG ?= $(shell basename $(shell dirname $(README_TEMPLATE_REPO_REMOTE)))
endif

# Parse git@github.com
ifneq (,$(findstring git@github.com,$(README_TEMPLATE_REPO_REMOTE)))
export README_TEMPLATE_REPO_ORG ?= $(lastword $(subst :, ,$(subst /,,$(dir $(README_TEMPLATE_REPO_REMOTE)))))
endif

export README_TEMPLATE_REPO ?= .github
export README_TEMPLATE_REPO_REF ?= blob/main
export README_TEMPLATE_REPO_PATH ?= README.md.gotmpl
export README_TEMPLATE_REPO_URL ?= https://github.com/$(README_TEMPLATE_REPO_ORG)/$(README_TEMPLATE_REPO)/$(README_TEMPLATE_REPO_REF)/$(README_TEMPLATE_REPO_PATH)?raw=true
export README_TEMPLATE_FILE ?= $(BUILD_HARNESS_PATH)/templates/README.md.gotmpl
export README_TEMPLATE_YAML := $(if $(findstring http,$(README_YAML)),$(README_YAML),$(BUILD_HARNESS_PATH)/templates/$(README_YAML))
export README_INCLUDES ?= $(file://$(shell pwd)/?type=text/plain)

# Create the README.md.gotmpl, if none exists by fetching it from the organization's `.github` repository
$(README_TEMPLATE_FILE):
	@echo GitHub Org: $(README_TEMPLATE_REPO_ORG)
	curl -o $@ -fsSL '$(README_TEMPLATE_REPO_URL)'

## Alias for readme/build
readme: readme/build
	@exit 0

readme/deps: packages/install/gomplate $(README_TEMPLATE_FILE)
	@exit 0

## Create basic minimalistic .README.md template file
readme/init:
	@if [ -f $(README_YAML) ]; then \
	  echo "$(README_YAML) already exists!"; \
	else \
	  cp $(README_TEMPLATE_YAML) $(README_YAML) ; \
	  echo "$(README_YAML) created!"; \
	fi;

## Verify the `README.md` is up to date
readme/lint:
	@$(SELF) readme/build README_FILE=$(README_LINT) >/dev/null
	@diff -ruN $(README_LINT) $(README_FILE)
	@rm -f $(README_LINT)

## Create README.md by building it from README.yaml
readme/build: readme/deps $(README_DEPS)
	@gomplate --file $(README_TEMPLATE_FILE) --out $(README_FILE) --config $(BUILD_HARNESS_PATH)/configs/gomplate.yaml
	@echo "Generated $(README_FILE) from $(README_TEMPLATE_FILE) using data from $(README_TEMPLATE_YAML)"

readme/generate-related-references:
	@$(BUILD_HARNESS_PATH)/bin/generate_related_references.py
