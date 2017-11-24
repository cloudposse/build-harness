BUILD_MAKER_PATH ?= .
OS ?= $(shell uname -s | tr '[:upper:]' '[:lower:]')
SELF ?= make
EDITOR ?= vi
SHELL = /bin/bash
BUILD_MAKER_ORG ?= neildmorris
BUILD_MAKER_PROJECT ?= build-maker
BUILD_MAKER_BRANCH ?= master
BUILD_MAKER_VERSION ?=
MODULES = $(shell awk -F "?" '{print $1}' requirements.make)

green = $(shell echo -e '\x1b[32;01m$1\x1b[0m')
yellow = $(shell echo -e '\x1b[33;01m$1\x1b[0m')
red = $(shell echo -e '\x1b[33;31m$1\x1b[0m')

.DEFAULT_GOAL := help

-include $(BUILD_MAKER_PATH)/.$(BUILD_MAKER_PROJECT).d/*

# Ensures that a variable is defined
define assert-set
  @[ -n "$($1)" ] || (echo "$(1) not defined in $(@)"; exit 1)
endef

# Ensures that a variable is undefined
define assert-unset
  @[ -z "$($1)" ] || (echo "$(1) should not be defined in $(@)"; exit 1)
endef

default:: help

.PHONY : help
## This help screen
help:
	@printf "Available targets:\n\n"
	@awk '/^[a-zA-Z\-\_0-9%:\\]+:/ { \
	  helpMessage = match(lastLine, /^## (.*)/); \
	  if (helpMessage) { \
	    helpCommand = $$1; \
	    helpMessage = substr(lastLine, RSTART + 3, RLENGTH); \
      gsub("\\\\", "", helpCommand); \
      gsub(":+$$", "", helpCommand); \
	    printf "  \x1b[32;01m%-35s\x1b[0m %s\n", helpCommand, helpMessage; \
	  } \
	} \
	{ lastLine = $$0 }' $(MAKEFILE_LIST) | sort -u
	@printf "\n"

.PHONY : init
init:
	@mkdir .$(BUILD_MAKER_PROJECT).d >/dev/null
	@$(MAKE) all >/dev/null

all: .$(BUILD_MAKER_PROJECT).d $(MODULES)

$(MODULES):
	@curl -sSL -o $(BUILD_MAKER_PATH)/.$(BUILD_MAKER_PROJECT).d/$@.make "https://raw.githubusercontent.com/$(BUILD_MAKER_ORG)/$(BUILD_MAKER_PROJECT)/$(BUILD_MAKER_BRANCH)/modules/$@/Makefile" >/dev/null

.PHONY : clean
	## Clean build-maker
clean:
		@rm -rf $(BUILD_MAKER_PATH)/.$(BUILD_MAKER_PROJECT)* >/dev/null
