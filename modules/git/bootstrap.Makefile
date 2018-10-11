export DEBUG ?= false

ifeq ($(wildcard .git),)
  ifeq ($(DEBUG),true)
    $(warning disabling git bootstrapping)
  endif
else

GIT ?= $(shell which git)

export GIT_COMMIT ?= $(shell $(GIT) rev-parse --verify HEAD)
export GIT_COMMIT_SHORT ?= $(shell $(GIT) rev-parse --verify --short HEAD)
export GIT_BRANCH ?= $(shell $(GIT) rev-parse --abbrev-ref HEAD)
export GIT_TAG ?= $(shell $(GIT) tag -l --sort -taggerdate --points-at HEAD | head -n 1)

export GIT_TIMESTAMP ?= $(shell $(GIT) log -1 --format=%ct 2>/dev/null)

ifeq ($(GIT_TAG),)
  export GIT_IS_TAG := 0
else
  export GIT_IS_TAG := 1
endif

ifeq ($(GIT_BRANCH),)
  export GIT_IS_BRANCH := 0
else
  export GIT_IS_BRANCH := 1
endif

export GIT_REPO ?= $(shell basename $$(git remote get-url origin) .git)
export GIT_ORG ?= $(shell dirname $$(git remote get-url origin) | cut -d: -f2)

endif
