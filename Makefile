# templates/Makefile.build-harness includes this Makefile
# and this Makefile includes templates/Makefile.build-harness
# to support different modes of invocation. Use a guard variable
# to prevent infinite recursive includes
ifeq ($(BUILD_HARNESS_TOP_LEVEL_MAKEFILE_GUARD),)
BUILD_HARNESS_TOP_LEVEL_MAKEFILE_GUARD := included

export OS ?= $(shell uname -s | tr '[:upper:]' '[:lower:]')
export BUILD_HARNESS_PATH ?= $(shell 'pwd')
export BUILD_HARNESS_EXTENSIONS_PATH ?= $(BUILD_HARNESS_PATH)/../build-harness-extensions
export BUILD_HARNESS_OS ?= $(OS)
export BUILD_HARNESS_ARCH ?= $(shell uname -m | sed 's/x86_64/amd64/g')
export SELF ?= $(MAKE)
export PATH := $(BUILD_HARNESS_PATH)/vendor:$(PATH)
export DOCKER_BUILD_FLAGS ?=

# Forces auto-init off to avoid invoking the macro on recursive $(MAKE)
export BUILD_HARNESS_AUTO_INIT := false

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
include $(BUILD_HARNESS_PATH)/templates/Makefile.build-harness
# Don't fail if there are no build harness extensions
# Wildcard conditions is to fixes `make[1]: *** No rule to make target` error
ifneq ($(wildcard $(BUILD_HARNESS_EXTENSIONS_PATH)/modules/*/Makefile*),)
-include $(BUILD_HARNESS_EXTENSIONS_PATH)/modules/*/Makefile*
endif

# For backwards compatibility with all of our other projects that use build-harness
init::
	exit 0

ifndef TRANSLATE_COLON_NOTATION
%:
	@$(SELF) -s $(subst :,/,$@) TRANSLATE_COLON_NOTATION=false
endif

endif

# builder/build is defined in templates/Makefile.build-harness
build: builder/build
