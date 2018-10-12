CF_TRIGGER_TYPE ?= build
CF_TRIGGER_REPO_NAME ?= $(CF_REPO_NAME)
CF_TRIGGER_BRANCH ?= $(CF_BRANCH)
CF_TRIGGER_REPO_OWNER ?= $(CF_REPO_OWNER)

## Trigger a CodeFresh WebHook
codefresh/trigger/webhook:
	@curl 'https://g.codefresh.io/api/builds/$(CF_TRIGGER_SERVICE_ID)' \
	 --compressed \
	 -H 'content-type:application/json; charset=utf-8' \
	 -H 'x-access-token: $(CF_ACCESS_TOKEN)' \
	 --data-binary \
		'{"serviceId":"$(CF_TRIGGER_SERVICE_ID)","type":"$(CF_TRIGGER_TYPE)","repoOwner":"$(CF_TRIGGER_REPO_OWNER)","branch":"$(CF_TRIGGER_BRANCH)","repoName":"$(CF_TRIGGER_REPO_NAME)"}'

## DEPRECATED!!! Export codefresh additional envvars
codefresh/export:
	$(call assert-set,CF_BUILD_TIMESTAMP)
	@echo "CF_BUILD_UNIX_TIMESTAMP=$(shell expr $(CF_BUILD_TIMESTAMP) / 1000)"
