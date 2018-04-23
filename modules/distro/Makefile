export INSTALL_PATH ?= $(BUILD_HARNESS_PATH)/vendor
export DISTRO_VERSION ?= init
export DISTRO_PATH ?= $(BUILD_HARNESS_PATH)/vendor/distro

## Install distro 
distro/install:
	@if [ ! -d $(DISTRO_PATH) ]; then \
	  echo "Installing distro $(DISTRO_VERSION)..."; \
	  rm -rf $(DISTRO_PATH); \
	  git clone --depth=1 -b $(DISTRO_VERSION) https://github.com/cloudposse/distro.git $(DISTRO_PATH); \
	  rm -rf $(DISTRO_PATH)/.git; \
	fi

## Install package (e.g. helm, helmfile, kubectl)
distro/install/%: distro/install
	@make -C $(DISTRO_PATH)/install $(subst distro/install/,,$@)
