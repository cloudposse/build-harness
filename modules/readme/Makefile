export README_LINT ?= $(TMP)/README.md
export README_FILE ?= README.md
export README_YAML ?= README.yaml

export README_TEMPLATE_REPO_REMOTE_NAME ?= origin
export README_TEMPLATE_REPO_REMOTE ?= $(shell [ -d .git ] && git remote get-url $(README_TEMPLATE_REPO_REMOTE_NAME))

# Parse https://github.com/...
ifneq (,$(findstring https://github.com/,$(README_TEMPLATE_REPO_REMOTE)))
URL_NO_PROTOCOL := $(subst https://github.com/,,$(README_TEMPLATE_REPO_REMOTE))
export README_TEMPLATE_REPO_ORG ?= $(firstword $(subst /, ,$(URL_NO_PROTOCOL)))
endif

# Parse git@github.com:...
ifneq (,$(findstring git@github.com:,$(README_TEMPLATE_REPO_REMOTE)))
URL_NO_GIT := $(subst git@github.com:,,$(README_TEMPLATE_REPO_REMOTE))
export README_TEMPLATE_REPO_ORG ?= $(firstword $(subst /, ,$(URL_NO_GIT)))
endif

export README_TEMPLATE_REPO ?= .github
export README_TEMPLATE_REPO_REF ?= main
export README_TEMPLATE_REPO_PATH ?= README.md.gotmpl
export README_TEMPLATE_REPO_URL := https://raw.githubusercontent.com/$${README_GITHUB_ORG}/$(README_TEMPLATE_REPO)/$(README_TEMPLATE_REPO_REF)/$(README_TEMPLATE_REPO_PATH)
export README_TEMPLATE_FILE ?= $(BUILD_HARNESS_PATH)/templates/README.md.gotmpl
export README_TEMPLATE_YAML := $(BUILD_HARNESS_PATH)/templates/$(README_YAML)

# Only allow allowlisted orgs to supply the README template
export README_ALLOWLIST_ORGS := \
	cloudposse \
	cloudposse-archives \
	cloudposse-corp \
	cloudposse-depos \
	cloudposse-examples \
	cloudposse-github-actions \
	cloudposse-sandbox \
	cloudposse-terraform-components \
	terraform-aws-components

# Fetch the README.md.gotmpl every time, because we have no way of knowing if it's changed
.PHONY: $(README_TEMPLATE_FILE)

# Fetch the README.md.gotmpl corresponding to this repo's GitHub Org
$(README_TEMPLATE_FILE):
	@for README_GITHUB_ORG in $(README_ALLOWLIST_ORGS); do \
		if [ "$${README_GITHUB_ORG}" == "$${README_TEMPLATE_REPO_ORG}" ]; then \
			curl -o $@ -fsSL "$(README_TEMPLATE_REPO_URL)"; \
			exit 0; \
		fi; \
	done; \
	printf "Detected GitHub Org '%s' is not in the list of organizations allowed to provide README templates.\n" "$(README_TEMPLATE_REPO_ORG)" >&2; \
	exit 1

## Alias for readme/build
readme: readme/build
	@exit 0

readme/deps: packages/install/gomplate
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
readme/build: readme/deps $(README_TEMPLATE_FILE) $(README_DEPS)
	@gomplate --file $(README_TEMPLATE_FILE) --out $(README_FILE) --config $(BUILD_HARNESS_PATH)/configs/gomplate.yaml
	@echo "Generated $(README_FILE) from $(README_TEMPLATE_FILE) using data from $(README_TEMPLATE_YAML)"

readme/generate-related-references:
	@$(BUILD_HARNESS_PATH)/bin/generate_related_references.py
