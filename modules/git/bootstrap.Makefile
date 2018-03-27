GIT:= $(shell which git)

export GIT_COMMIT ?= $(shell $(GIT) rev-parse --verify HEAD)
export GIT_COMMIT_SHORT ?= $(shell $(GIT) rev-parse --verify --short HEAD)
export GIT_BRANCH ?= $(shell $(GIT) rev-parse --abbrev-ref HEAD)
export GIT_LATEST_TAG ?= $(shell $(GIT)  describe --tags --abbrev=0 2>/dev/null)

ifeq ($(GIT_LATEST_TAG),)
	export GIT_LATEST_TAG="0.0.0"
endif

ifeq ($(GIT_BRANCH),)
	export GIT_IS_BRANCH := 0
else
	export GIT_IS_BRANCH := 1
endif

ifeq ($(shell $(GIT) describe --exact-match --tags 2>/dev/null),)
	export GIT_IS_TAG := 0
else
	export GIT_IS_TAG := 1
endif
