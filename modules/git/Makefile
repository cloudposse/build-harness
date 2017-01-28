GIT:= $(shell which git)

.PHONY: git\:submodules-update
## Update submodules
git\:submodules-update:
	$(call assert-set,GIT)
	$(GIT) submodule update --init --remote