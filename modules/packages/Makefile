export INSTALL_PATH ?= $(BUILD_HARNESS_PATH)/vendor
export DISTRO_VERSION ?= init
export DISTRO_PATH ?= $(BUILD_HARNESS_PATH)/vendor/packages

## Install packages 
packages/install:
	@if [ ! -d $(DISTRO_PATH) ]; then \
	  echo "Installing packages $(DISTRO_VERSION)..."; \
	  rm -rf $(DISTRO_PATH); \
	  git clone --depth=1 -b $(DISTRO_VERSION) https://github.com/cloudposse/packages.git $(DISTRO_PATH); \
	  rm -rf $(DISTRO_PATH)/.git; \
	fi

## Install package (e.g. helm, helmfile, kubectl)
packages/install/%: packages/install
	@make -C $(DISTRO_PATH)/install $(subst packages/install/,,$@)
