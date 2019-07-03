export BUILD_HARNESS_PATH ?= $(shell 'pwd')
export BUILD_HARNESS_EXTENSIONS_PATH ?= $(BUILD_HARNESS_PATH)/../build-harness-extensions
export BUILD_HARNESS_ARCH ?= $(shell uname -m | sed 's/x86_64/amd64/g')
export OS ?= $(shell uname -s | tr '[:upper:]' '[:lower:]')
export SELF ?= $(MAKE)
export PATH := $(BUILD_HARNESS_PATH)/vendor:$(PATH)
export DOCKER_BUILD_FLAGS ?=

# Debug should not be defaulted to a value because some cli consider any value as `true` (e.g. helm)
export DEBUG ?=

ifeq ($(CURDIR),$(realpath $(BUILD_HARNESS_PATH)))
# List of targets the `readme` target should call before generating the readme
export README_DEPS ?= docs/targets.md
export DEFAULT_HELP_TARGET = help/all
endif

# Import Makefiles into current context
include $(BUILD_HARNESS_PATH)/Makefile.*
include $(BUILD_HARNESS_PATH)/modules/*/bootstrap.Makefile*
include $(BUILD_HARNESS_PATH)/modules/*/Makefile*
# Don't fail if there are no build harness extensions
-include $(BUILD_HARNESS_EXTENSIONS_PATH)/modules/*/Makefile*

ifndef TRANSLATE_COLON_NOTATION
%:
	@$(SELF) -s $(subst :,/,$@) TRANSLATE_COLON_NOTATION=false
endif
