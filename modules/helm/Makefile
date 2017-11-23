CURL := $(shell which curl)
HELM_VERSION ?= v2.3.1
HELM_PLATFORM ?= $(OS)-amd64
HELM := $(shell which helm)
HELM_REPO_NAMES ?= stable incubator demo
HELM_REPO_PREFIX ?= neildmorris

REPO_PATH ?= ./$(REPO_NAME)
PACKAGE_PATH ?= ./packages/$(REPO_NAME)

REPO_URL?=https://charts.neildmorris.com

ifneq ($(TRAVIS_PULL_REQUEST_BRANCH),)
  BRANCH=pr-$(TRAVIS_PULL_REQUEST_BRANCH)
else ifneq ($(TRAVIS_BRANCH),)
  BRANCH=$(TRAVIS_BRANCH)
else ifneq ($(TRAVIS_TAG),)
  BRANCH=$(TRAVIS_TAG)
else
  BRANCH=$(shell git rev-parse --abbrev-ref HEAD)
endif
ifeq ($(BRANCH),master)
	CURRENT_REPO_URL?=$(REPO_URL)
else
	CURRENT_REPO_URL?=https://charts.dev.neildmorris.com/$(BRANCH)
endif

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

.PHONY : helm\:repo\:info
## Show repo info
helm\:repo\:info:
	@echo "REPO_URL: $(REPO_URL)"
	@echo "CURRENT_REPO_URL: $(CURRENT_REPO_URL)"

.PHONY: helm\:repo\:add-remote
## Add helm remote repos
helm\:repo\:add-remote:
	@make helm:repo:add \
		HELM_REPO_URL=$(REPO_URL)

.PHONY: helm\:repo\:add-current
## Add helm remote dev repos
helm\:repo\:add-current:
	@make helm:repo:add \
		HELM_REPO_PREFIX=$(HELM_REPO_PREFIX)-dev \
		HELM_REPO_URL=$(CURRENT_REPO_URL)

helm\:repo\:add:
	@$(HELM) repo add kubernetes-charts http://storage.googleapis.com/kubernetes-charts
	@for repo in $(HELM_REPO_NAMES); do \
		if [ -d "$$repo" ]; then \
			curl --fail -s -q $(HELM_REPO_URL)/$$repo/index.yaml -o /dev/null; \
			if [ $$? -eq 0 ]; then \
				$(HELM) repo add $(HELM_REPO_PREFIX)-$$repo $(HELM_REPO_URL)/$$repo; \
			else \
				echo "$(HELM_REPO_URL)/$$repo not available"; \
			fi; \
		else \
			echo "$$repo does not exist; skipping..."; \
		fi; \
