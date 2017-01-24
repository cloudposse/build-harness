CURL:= $(shell which curl)
HELM_VERSION?=v2.1.3
HELM_PLATFORM?=linux-amd64
HELM:=$(shell which helm)

helm\:install:
	@$(CURL) https://kubernetes-helm.storage.googleapis.com/helm-$(HELM_VERSION)-$(HELM_PLATFORM).tar.gz | tar xvz
	@chmod +x $(HELM_PLATFORM)/helm
	@mv $(HELM_PLATFORM)/helm /usr/bin
	@helm init --client-only
