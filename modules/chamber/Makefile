CURL := $(shell which curl)
CHAMBER_VERSION ?= 2.0.0
CHAMBER := $(shell which chamber)

## Install chamber
chamber/install:
	@$(CURL) --fail -sSL https://github.com/segmentio/chamber/releases/download/v$(CHAMBER_VERSION)/chamber-v$(CHAMBER_VERSION)-$(OS)-amd64 -o /usr/local/bin/chamber
	@chmod +x /usr/local/bin/chamber


