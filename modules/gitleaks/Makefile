export GITLEAKS_VERSION ?= 1.2.0

GITLEAKS ?= gitleaks

## Install gitleaks
gitleaks/install: packages/install/gitleaks
	@exit 0

## Scan current repository
gitleaks/scan:
	@$(GITLEAKS) --repo=$(CURDIR) --verbose --redact
