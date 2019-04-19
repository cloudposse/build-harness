CURL ?= curl
HELM_PLATFORM ?= $(OS)-amd64
HELM ?= helm
HELM_HOME ?= $(HOME)/.helm
HELM_REPO_PATH ?= ./$(REPO_NAME)
HELM_PACKAGE_PATH ?= ./packages/$(REPO_NAME)

## Install helm
helm/install: packages/install/helm packages/install/yq
	@$(HELM) init --client-only
	@chmod -R 777 "$(HELM_HOME)"
	@$(HELM) repo remove local || true

## Build index for serve helm charts
helm/serve/index:
	$(call assert-set,CURRENT_REPO_URL)
	$(call assert-set,HELM)
	@$(SELF) helm/repo/index REPO_NAME=incubator
	@$(SELF) helm/repo/index REPO_NAME=stable

## Install or upgrade helm tiller 
helm/toolbox/upsert:
	@$(BUILD_HARNESS_PATH)/bin/helm_toolbox.sh upsert

## Delete all releases in a `NAMEPSACE` as well as the namespace
helm/delete/namespace:
	$(call assert-set,NAMESPACE)
	@echo "Purging all helm releases in the $(NAMESPACE) namespace"
	@$(HELM) list --namespace $(NAMESPACE) --short | xargs -r $(HELM) delete --purge
	@kubectl delete namespace $(NAMESPACE) --ignore-not-found

## Delete `NAMESPACE` if there are no releases in it
helm/delete/namespace/empty:
	$(call assert-set,NAMESPACE)
	@[ -n "$$($(HELM) list --namespace $(NAMESPACE) --short --all)" ] || kubectl delete namespace $(NAMESPACE) --ignore-not-found

## Delete all failed releases in a `NAMESPACE` subject to `FILTER`
helm/delete/failed:
	@$(HELM) list --namespace $(NAMESPACE) --failed --short $(FILTER) 2>/dev/null | xargs -r $(HELM) delete --purge
