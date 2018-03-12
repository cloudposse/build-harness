GIT:= $(shell which git)

## Update submodules
git/submodules-update:
	$(call assert-set,GIT)
	$(GIT) submodule update --init --remote

## Update git aliases
git/aliases-update:
	@$(GIT) config --global --add alias.permission-reset '!git diff -p -R --no-color | grep -E "^(diff|(old|new) mode)" --color=never | git apply'

## Show vars
git/show:
	@echo "commit - $(GIT_COMMIT)"
	@echo "commit short - $(GIT_COMMIT_SHORT)"
	@echo "commit branch - $(GIT_BRANCH)"
	@echo "latest tag - $(GIT_LATEST_TAG)"
	@echo "tag - $(GIT_IS_TAG)"
	@echo "branch - $(GIT_IS_BRANCH)"

## Export git vars
git/export:
	@echo "GIT_COMMIT=$(GIT_COMMIT)"
	@echo "GIT_COMMIT_SHORT=$(GIT_COMMIT_SHORT)"
	@echo "GIT_BRANCH=$(GIT_BRANCH)"
	@echo "GIT_LATEST_TAG=$(GIT_LATEST_TAG)"
	@echo "GIT_IS_BRANCH=$(GIT_IS_BRANCH)"
	@echo "GIT_IS_TAG=$(GIT_IS_TAG)"
