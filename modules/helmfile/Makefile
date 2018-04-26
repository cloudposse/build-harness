CURL := $(shell which curl)
HELMFILE_VERSION ?= 0.12.0
HELMFILE := $(shell which helm)

## Install helmfile
helmfile/install: packages/install/helmfile packages/install/kubectl packages/install/helm
	@exit 0


