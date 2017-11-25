
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

.PHONY: travis\:docker-login travis\:docker-tag-and-push

# Allow docker actions on push to source repo or on PR's from trusted source only
# check if we outside of Travis environment
ifneq ($(TRAVIS), true)
  ALLOW_DOCKER_ACTIONS := true
# check if it’s not a pull request
else ifeq ($(TRAVIS_PULL_REQUEST), false)
  ALLOW_DOCKER_ACTIONS := true
# check if pull request from originating repo
else ifeq ($(TRAVIS_REPO_SLUG), $(TRAVIS_PULL_REQUEST_SLUG))
  ALLOW_DOCKER_ACTIONS := true
else
  ALLOW_DOCKER_ACTIONS := false
endif

## Login into docker hub
travis\:docker-login:
ifeq ($(ALLOW_DOCKER_ACTIONS),true)
	@make docker:login
else
	@echo "Skipping docker login for untrusted builds"
endif

## Tag & Push according Travis environment variables
travis\:docker-tag-and-push:
ifeq ($(ALLOW_DOCKER_ACTIONS),true)
	$(call assert-set,DOCKER_IMAGE_NAME)
	$(BUILD_MAKER_PATH)/bin/travis_docker_tag_and_push.sh
else
	@echo "Skipping docker tag and push for untrusted builds"
endif
