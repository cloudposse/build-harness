DOCKER:= $(shell which docker)

DOCKER_CMD ?= docker run -i --rm --network=$(DOCKER_NETWORK)
SSH_EXEC ?= $(DOCKER) exec -it
CONTAINER_SHELL ?= sh

# Connect ssh $host
define ssh
	@[ -n "$1" ] || (echo "Specify container name in $(@)"; exit 1)
	@$(SSH_EXEC) $1 $2
endef
