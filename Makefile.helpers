#
# Helpers - stuff that's shared between make files
#

EDITOR ?= vim

SHELL = /bin/bash

DEFAULT_HELP_TARGET ?= help/short
HELP_FILTER ?= .*

green = $(shell echo -e '\x1b[32;01m$1\x1b[0m')
yellow = $(shell echo -e '\x1b[33;01m$1\x1b[0m')
red = $(shell echo -e '\x1b[33;31m$1\x1b[0m')


# Ensures that a variable is defined
define assert-set
  @[ -n "$($1)" ] || (echo "$(1) not defined in $(@)"; exit 1)
endef

# Ensures that a variable is undefined
define assert-unset
  @[ -z "$($1)" ] || (echo "$(1) should not be defined in $(@)"; exit 1)
endef

default:: $(DEFAULT_HELP_TARGET)
	@exit 0

## Help screen
help:
	@printf "Available targets:\n\n"
	@$(SELF) -s help/generate | grep -E "\w($(HELP_FILTER))"

## Display help for all targets
help/all:
	@printf "Available targets:\n\n"
	@$(SELF) -s help/generate

## This help short screen
help/short:
	@printf "Available targets:\n\n"
	@$(SELF) -s help/generate MAKEFILE_LIST="Makefile $(BUILD_HARNESS_PATH)/Makefile.helpers"

# Generate help output from MAKEFILE_LIST
help/generate:
	@awk '/^[a-zA-Z\_0-9%:\\\/-]+:/ { \
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
