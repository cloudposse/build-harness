FEATURE_PATTERN ?= "^feature-\d*"

ifeq ($(GIT_IS_TAG),1)
  FEATURE ?= $(GIT_LATEST_TAG)
endif

ifeq ($(GIT_IS_BRANCH),1)
  ifneq ($(shell echo $(GIT_BRANCH) | grep -Eo $(FEATURE_PATTERN)),)
    FEATURE ?= $(shell echo $(GIT_BRANCH) | grep -Eo $(FEATURE_PATTERN))
  else
    FEATURE ?= "$(GIT_BRANCH)"
  endif
endif

## Export stages vars
stages/export:
	$(call assert-set,PROJECT)
	$(call assert-set,FEATURE)
	@echo "PROJECT=$(PROJECT)"
	@echo "FEATURE=$(FEATURE)"
	@echo "NAMESPACE=$(PROJECT)-$(FEATURE)"
