CURL:= $(shell which curl)
HELM_VERSION?=v2.1.3
HELM_PLATFORM?=linux-amd64
HELM:=$(shell which helm)

.PHONY: helm\:install
## Install helm
helm\:install:
	@$(CURL) https://kubernetes-helm.storage.googleapis.com/helm-$(HELM_VERSION)-$(HELM_PLATFORM).tar.gz | tar xvz
	@chmod +x $(HELM_PLATFORM)/helm
	@mv $(HELM_PLATFORM)/helm /usr/bin
	@helm init --client-only
	@chmod -R 777 $(HOME)/.helm

.PHONY: helm\:serve\:index
## Build index for serve helm charts
helm\:serve\:index:
	$(call assert-set,CURRENT_REPO_URL)
	$(call assert-set,HELM)
	@make helm:repo:index REPO_PATH=incubator
	@make helm:repo:index REPO_PATH=stable