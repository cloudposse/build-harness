CURL := $(shell which curl)
export HELM_VERSION ?= 2.9.0-rc5
HELM_PLATFORM ?= $(OS)-amd64
HELM := $(shell which helm)
HELM_HOME ?= $(HOME)/.helm

HELM_REPO_PATH ?= ./$(REPO_NAME)
HELM_PACKAGE_PATH ?= ./packages/$(REPO_NAME)

## Install helm
helm/install: packages/install/helm packages/install/yq
	@helm init --client-only
	@chmod -R 777 "$(HELM_HOME)"
	@helm repo remove local || true

## Build index for serve helm charts
helm/serve/index:
	$(call assert-set,CURRENT_REPO_URL)
	$(call assert-set,HELM)
	@$(SELF) helm/repo/index REPO_NAME=incubator
	@$(SELF) helm/repo/index REPO_NAME=stable

## Install or upgrade helm tiller 
helm/toolbox/upsert:
	@$(BUILD_HARNESS_PATH)/bin/helm_toolbox.sh upsert

