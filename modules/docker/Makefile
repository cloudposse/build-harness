DOCKER ?= docker

DOCKER_RUN ?= "$(DOCKER)" run -i --rm --network=$(DOCKER_NETWORK)
DOCKER_EXEC ?= "$(DOCKER)" exec -it
CONTAINER_SHELL ?= sh

# It's like ssh for docker
define docker-exec
	@[ -n "$1" ] || (echo "Specify container name in $(@)"; exit 1)
	@$(DOCKER_EXEC) $1 $2
endef
