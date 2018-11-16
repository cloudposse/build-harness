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
export GIT_COMMIT_URL ?= $(shell $(GIT) config --get remote.origin.url | sed 's/\.git$$//g' | sed 's/git@\(.*\):/https:\/\/\1\//g' )/commit/$(GIT_COMMIT_SHORT)

export GIT_COMMIT_MESSAGE ?= $(shell $(GIT) show -s --format=%s%b)
export GIT_COMMIT_AUTHOR ?= $(shell $(GIT) show -s --format=%aN)
export GIT_COMMIT_TIMESTAMP ?= $(shell $(GIT) log -1 --format=%ct 2>/dev/null)


## GIT_TIMESTAMP is deprecated. Use GIT_COMMIT_TIMESTAMP instead
export GIT_TIMESTAMP ?= $(shell $(GIT) log -1 --format=%ct 2>/dev/null)

ifeq ($(GIT_TAG),)
  export GIT_IS_TAG := 0
  export GIT_BRANCH_TAG ?= $(GIT_BRANCH)
else
  export GIT_IS_TAG := 1
  export GIT_BRANCH_TAG ?= $(GIT_TAG)
endif

ifeq ($(GIT_BRANCH),)
  export GIT_IS_BRANCH := 0
else
  export GIT_IS_BRANCH := 1
endif

export GIT_URL ?= $(shell git remote get-url origin)
export GIT_REPO ?= $(shell basename $(GIT_URL) .git)
export GIT_ORG ?= $(shell basename $$(dirname $(GIT_URL) | cut -d: -f2))

endif
