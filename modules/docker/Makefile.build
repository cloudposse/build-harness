## Use DOCKER_IMAGE_NAME envvar to specify docker image with tags
## User ARGS to pass arguments
DOCKER_BUILD_PATH ?= .
DOCKER_BUILD_FLAGS ?= --no-cache
DOCKER_FILE ?= ./Dockerfile

.PHONY: docker\:build
## Build docker image
docker\:build: $(DOCKER)
	$(call assert-set,DOCKER)
	$(call assert-set,DOCKER_IMAGE_NAME)
ifeq ($(TRAVIS),true)
	git ls-files -s | awk '{print $$1" "$$4}' | grep '^10' | sed s'/^..//' | xargs --no-run-if-empty -n 2 echo chmod  | bash -x
endif
	@BUILD_ARGS=`for arg in $$ARGS; do \
		printf -- '--build-arg %s=%s ' "$$arg" "$${!arg}"; \
	done`; \
	echo "Building $(DOCKER_IMAGE_NAME) from $(DOCKER_FILE) with [$(DOCKER_BUILD_FLAGS)] build args..."; \
	$(DOCKER) build $(DOCKER_BUILD_FLAGS) $$BUILD_ARGS -t $(DOCKER_IMAGE_NAME) -f $(DOCKER_FILE) $(DOCKER_BUILD_PATH)
