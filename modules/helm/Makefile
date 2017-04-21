CURL := $(shell which curl)
HELM_VERSION ?= v2.3.1
HELM_PLATFORM ?= $(OS)-amd64
HELM := $(shell which helm)

.PHONY: helm\:install
## Install helm
helm\:install:
	@$(CURL) https://kubernetes-helm.storage.googleapis.com/helm-$(HELM_VERSION)-$(HELM_PLATFORM).tar.gz | tar xvz
	@chmod +x $(HELM_PLATFORM)/helm
	@mv $(HELM_PLATFORM)/helm /usr/local/bin/
	@helm init --client-only
	@chmod -R 777 $(HOME)/.helm
	@helm repo remove local || true

.PHONY: helm\:serve\:index
## Build index for serve helm charts
helm\:serve\:index:
	$(call assert-set,CURRENT_REPO_URL)
	$(call assert-set,HELM)
	@make helm:repo:index REPO_NAME=incubator
	@make helm:repo:index REPO_NAME=stable
