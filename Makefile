export BUILD_HARNESS_PATH ?= $(shell 'pwd')
export OS ?= $(shell uname -s | tr '[:upper:]' '[:lower:]')
export SELF ?= make
export PATH := $(BUILD_HARNESS_PATH)/vendor:$(PATH)
export DOCKER_BUILD_FLAGS ?=

# List of targets the `readme` target should call before generating the readme
export README_DEPS ?= docs/targets.md

# Import Makefiles into current context
include $(BUILD_HARNESS_PATH)/Makefile.*
include $(BUILD_HARNESS_PATH)/modules/*/bootstrap.Makefile*
include $(BUILD_HARNESS_PATH)/modules/*/Makefile*

ifndef TRANSLATE_COLON_NOTATION
%:
	@$(SELF) $(subst :,/,$@) TRANSLATE_COLON_NOTATION=false
endif


.PHONY : docs/targets.md
## Update `docs/targets.md` from `make help`
docs/targets.md:
	@( \
		echo "## Makefile Targets"; \
		echo '```'; \
		$(SELF) help | sed $$'s,\x1b\\[[0-9;]*[a-zA-Z],,g'; \
		echo '```'; \
	) > $@
