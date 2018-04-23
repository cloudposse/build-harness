CURL := $(shell which curl)
HELMFILE_VERSION ?= 0.12.0
HELMFILE := $(shell which helm)

## Install helmfile
helmfile/install: distro/install/helmfile distro/install/kubectl distro/install/helm
	@exit 0


