CURL ?= curl
HELMFILE ?= helmfile

## Install helmfile
helmfile/install:
	@$(MAKE) -s packages/install/helmfile
	@$(MAKE) -s packages/install/kubectl
	@$(MAKE) -s packages/install/helm
	@exit 0


