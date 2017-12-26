GIT:= $(shell which git)

export GIT_COMMIT = $(shell $(GIT) rev-parse --verify HEAD)
export GIT_COMMIT_SHORT = $(shell $(GIT)  rev-parse --verify --short HEAD)
export GIT_BRANCH = $(shell $(GIT)  branch | grep \* | cut -d ' ' -f2 | grep -v detached)

export GIT_LATEST_TAG = $(shell $(GIT)  describe --tags --abbrev=0 2>/dev/null)
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


.PHONY: git\:submodules-update
## Update submodules
git\:submodules-update:
	$(call assert-set,GIT)
	$(GIT) submodule update --init --remote

.PHONY: git\:aliases-update
## Update git aliases
git\:aliases-update:
	@$(GIT) config --global --add alias.permission-reset '!git diff -p -R --no-color | grep -E "^(diff|(old|new) mode)" --color=never | git apply'

## Test
git\:test:
	@echo "commit - $(GIT_COMMIT)"
	@echo "commit short - $(GIT_COMMIT_SHORT)"
	@echo "commit branch - $(GIT_BRANCH)"
	@echo "latest tag - $(GIT_LATEST_TAG)"
	@echo "tag - $(GIT_IS_TAG)"
	@echo "branch - $(GIT_IS_BRANCH)"