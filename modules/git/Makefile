GIT:= $(shell which git)

## Update submodules
git/submodules-update:
	$(call assert-set,GIT)
	$(GIT) submodule update --init --remote

## Update git aliases
git/aliases-update:
	@$(GIT) config --global --add alias.permission-reset '!git diff -p -R --no-color | grep -E "^(diff|(old|new) mode)" --color=never | git apply'
