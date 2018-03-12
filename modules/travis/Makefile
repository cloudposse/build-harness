
# Generate the canonical tag
ifneq ($(TRAVIS_PULL_REQUEST_BRANCH),)
  CANONICAL_TAG ?= pr-$(TRAVIS_PULL_REQUEST_BRANCH)-$(TRAVIS_BUILD_NUMBER)
else ifneq ($(TRAVIS_BRANCH),)
  CANONICAL_TAG ?= $(TRAVIS_BRANCH)-$(TRAVIS_BUILD_NUMBER)
else ifneq ($(TRAVIS_TAG),)
  CANONICAL_TAG ?= $(TRAVIS_TAG)-$(TRAVIS_BUILD_NUMBER)
else
  CANONICAL_TAG ?= $(shell git rev-parse --abbrev-ref HEAD)
endif

export CANONICAL_TAG
