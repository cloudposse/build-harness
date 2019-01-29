LATEST_TAG_STRING = "latest"

ifeq ($(CF_BUILD_ID),)
## this is not a Codefresh build context
	export IS_CODEFRESH := 0
else
	export IS_CODEFRESH := 1
## common build ID we can use with different CI/CD systems
  export CICD_BUILD_ID := "$(CF_BUILD_ID)"
  export CICD_COMMIT := "$(CF_REVISION)"

  ifneq ($(CF_PULL_REQUEST_ID),)
    export CICD_DOCKER_IMAGE_PULL_REQUEST_TAG := "pr-$(CF_BRANCH_TAG_NORMALIZED)-$(CF_BUILD_ID)"

    ifeq ($(CF_PULL_REQUEST_ACTION),closed)
      export CICD_DOCKER_IMAGE_LATEST_TAG := $(LATEST_TAG_STRING)
    endif

  endif

  ifeq ($(CF_BRANCH),master)
    export CICD_DOCKER_IMAGE_LATEST_TAG := $(LATEST_TAG_STRING)
  endif

endif