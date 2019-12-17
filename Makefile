export BUILD_HARNESS_PATH ?= $(shell 'pwd')
export OS ?= $(shell uname -s | tr '[:upper:]' '[:lower:]')
export SELF ?= $(MAKE)
export PATH := $(BUILD_HARNESS_PATH)/vendor:$(PATH)
export DOCKER_BUILD_FLAGS ?=

# Debug should not be defaulted to a value because some cli consider any value as `true` (e.g. helm)
export DEBUG ?=

ifeq ($(CURDIR),$(realpath $(BUILD_HARNESS_PATH)))
# Only execute this section if we're actually in the `build-harness` project itself
# List of targets the `readme` target should call before generating the readme
export README_DEPS ?= docs/targets.md auto-label
export DEFAULT_HELP_TARGET = help/all

auto-label: MODULES=$(filter %/, $(sort $(wildcard modules/*/)))
auto-label:
	for module in $(MODULES); do \
		echo "$${module%/}: $${module}**"; \
	done > .github/$@.yml
endif

# Import Makefiles into current context
include $(BUILD_HARNESS_PATH)/Makefile.*
include $(BUILD_HARNESS_PATH)/modules/*/bootstrap.Makefile*
include $(BUILD_HARNESS_PATH)/modules/*/Makefile*

# For backwards compatibility with all of our other projects that use build-harness
init::
	exit 0

ifndef TRANSLATE_COLON_NOTATION
%:
	@$(SELF) -s $(subst :,/,$@) TRANSLATE_COLON_NOTATION=false
endif
