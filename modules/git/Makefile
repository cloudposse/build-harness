GIT:= $(shell which git)

export GIT_COMMIT ?= $(shell $(GIT) rev-parse --verify HEAD)
export GIT_COMMIT_SHORT ?= $(shell $(GIT)  rev-parse --verify --short HEAD)
export GIT_BRANCH ?= $(shell $(GIT)  branch | grep \* | cut -d ' ' -f2 | grep -Ev "^\W" )

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

define git_vars_export
GIT_COMMIT=$(GIT_COMMIT)
GIT_COMMIT_SHORT=$(GIT_COMMIT_SHORT)
GIT_BRANCH=$(GIT_BRANCH)
GIT_LATEST_TAG=$(GIT_LATEST_TAG)
GIT_IS_BRANCH=$(GIT_IS_BRANCH)
GIT_IS_TAG=$(GIT_IS_TAG)
endef

export git_vars_export

.PHONY: git\:submodules-update
## Update submodules
git\:submodules-update:
	$(call assert-set,GIT)
	$(GIT) submodule update --init --remote

.PHONY: git\:aliases-update
## Update git aliases
git\:aliases-update:
	@$(GIT) config --global --add alias.permission-reset '!git diff -p -R --no-color | grep -E "^(diff|(old|new) mode)" --color=never | git apply'

## Show vars
git\:show:
	@echo "commit - $(GIT_COMMIT)"
	@echo "commit short - $(GIT_COMMIT_SHORT)"
	@echo "commit branch - $(GIT_BRANCH)"
	@echo "latest tag - $(GIT_LATEST_TAG)"
	@echo "tag - $(GIT_IS_TAG)"
	@echo "branch - $(GIT_IS_BRANCH)"

## Export git vars
git\:export:
	@echo "git_vars_export"