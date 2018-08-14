DOCKER_NETWORK ?= $(COMPOSE_PROJECT_NAME)_default

DOCKER_MONITOR_TABLE ?= 'table {{.Name}}\t{{.CPUPerc}}\t{{.MemUsage}}\t{{.NetIO}}\t{{.BlockIO}}'

DOCKER_COMPOSE ?= docker-compose

## Start local dev environment (daemonized)
compose/up:
	@$(DOCKER_COMPOSE) up -d

## Stop local dev environment
compose/down:
	@$(DOCKER_COMPOSE) down

## Restart local dev environment
compose/restart: compose/down compose/up

## Purge local dev environment
compose/purge:
	@$(DOCKER_COMPOSE) down -v

## Rebuild custom containers for local dev environment
compose/rebuild: compose/down compose/build compose/up

## Build local dev environment
compose/build:
	@$(DOCKER_COMPOSE) build

## Show containers resource usage
compose/monitor:
	@$(DOCKER_COMPOSE) ps -q | tr '\n' ' ' | docker stats --format $(DOCKER_MONITOR_TABLE) --no-stream

## Monitor in time containers resource usage
compose/monitor/follow:
	@$(DOCKER_COMPOSE) ps -q | tr '\n' ' ' | docker stats --format $(DOCKER_MONITOR_TABLE)

## Show top for containers
compose/top:
	@$(DOCKER_COMPOSE) top
