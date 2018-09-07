export GITLEAKS_VERSION ?= 1.2.0

GITLEAKS ?= gitleaks

## Install gitleaks
gitleaks/install: packages/install/gitleaks

## Scan current repository
gitleaks/scan:
	@$(GITLEAKS) --repo=$(CURDIR) --verbose --redact
