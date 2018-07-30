export BUILD_HARNESS_PATH ?= $(shell 'pwd')
export OS ?= $(shell uname -s | tr '[:upper:]' '[:lower:]')
export SELF ?= $(MAKE)
export PATH := $(BUILD_HARNESS_PATH)/vendor:$(PATH)
export DOCKER_BUILD_FLAGS ?=

ifeq ($(CURDIR),$(realpath $(BUILD_HARNESS_PATH)))
# List of targets the `readme` target should call before generating the readme
export README_DEPS ?= docs/targets.md
export DEFAULT_HELP_TARGET = help/all
endif

# Import Makefiles into current context
include $(BUILD_HARNESS_PATH)/Makefile.*
include $(BUILD_HARNESS_PATH)/modules/*/bootstrap.Makefile*
include $(BUILD_HARNESS_PATH)/modules/*/Makefile*

ifndef TRANSLATE_COLON_NOTATION
%:
	@$(SELF) $(subst :,/,$@) TRANSLATE_COLON_NOTATION=false
endif



