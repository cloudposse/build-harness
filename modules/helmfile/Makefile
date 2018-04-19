CURL := $(shell which curl)
HELMFILE_VERSION ?= 0.12.0
HELMFILE := $(shell which helm)

## Install helmfile
helmfile/install:
	@$(CURL) --fail -sSL https://github.com/roboll/helmfile/releases/download/v$(HELMFILE_VERSION)/helmfile_$(OS)_amd64 -o /usr/local/bin/helmfile
	@chmod +x /usr/local/bin/helmfile


