## Array of all possible versions based on this git commit
SEMVERSIONS :=

## Version based on short commit. ex.: 0.3.1-sha.80b9f6f
SEMVERSION_COMMIT_SHORT = $(GIT_LATEST_TAG)-sha.$(GIT_COMMIT_SHORT)
SEMVERSIONS += $(SEMVERSION_COMMIT_SHORT)

## Version based on long commit. ex.: 0.3.1-sha.80b9f6f5b965555e406b9db066a8e16cb1075e5f
SEMVERSION_COMMIT = $(GIT_LATEST_TAG)-sha.$(GIT_COMMIT)
SEMVERSIONS += $(SEMVERSION_COMMIT)

## If we are on git tag. ex.: 0.3.1
SEMVERSION_TAG =
ifeq ($(GIT_IS_TAG),1)
  ## Version based on tag. ex.: 0.3.1
  SEMVERSION_TAG = $(GIT_LATEST_TAG)
  SEMVERSIONS += $(SEMVERSION_TAG)
endif

## If we are on git branch. ex.: master
SEMVERSION_BRANCH=
SEMVERSION_BRANCH_COMMIT_SHORT=
SEMVERSION_BRANCH_COMMIT=
ifeq ($(GIT_IS_BRANCH),1)
  ## Version based on branch. ex.: 0.3.1-master
  SEMVERSION_BRANCH = $(GIT_LATEST_TAG)-$(GIT_BRANCH)
  SEMVERSIONS += $(SEMVERSION_BRANCH)

  ## Version based on branch and short commit. ex.: 0.3.1-master.sha.80b9f6f
  SEMVERSION_BRANCH_COMMIT_SHORT = $(GIT_LATEST_TAG)-$(GIT_BRANCH).sha.$(GIT_COMMIT_SHORT)
  SEMVERSIONS += $(SEMVERSION_BRANCH_COMMIT_SHORT)

  ## Version based on branch and long commit. ex.: 0.3.1-master.sha.80b9f6f5b965555e406b9db066a8e16cb1075e5f
  SEMVERSION_BRANCH_COMMIT = $(GIT_LATEST_TAG)-$(GIT_BRANCH).sha.$(GIT_COMMIT)
  SEMVERSIONS += $(SEMVERSION_BRANCH_COMMIT)
endif

## Use as default version first of possible versions
export SEMVERSION ?= $(word 1,$(SEMVERSIONS))

## Show
semver/show:
	@for version in $(SEMVERSIONS) ; do \
		echo "$$version"; \
	done

## Export semver vars
semver/export:
	@echo "SEMVERSION_COMMIT_SHORT=$(SEMVERSION_COMMIT_SHORT)"
	@echo "SEMVERSION_COMMIT=$(SEMVERSION_COMMIT)"
	@echo "SEMVERSION_BRANCH=$(SEMVERSION_BRANCH)"
	@echo "SEMVERSION_BRANCH_COMMIT_SHORT=$(SEMVERSION_BRANCH_COMMIT_SHORT)"
	@echo "SEMVERSION_BRANCH_COMMIT=$(SEMVERSION_BRANCH_COMMIT)"
	@echo "SEMVERSION_TAG=$(SEMVERSION_TAG)"
