export INSTALL_PATH ?= $(BUILD_HARNESS_PATH)/vendor
export PACKAGES_VERSION ?= 0.8.0
export PACKAGES_PATH ?= $(BUILD_HARNESS_PATH)/vendor/packages

## Delete packages
packages/delete:
	rm -rf $(PACKAGES_PATH)

## Reinstall packages
packages/reinstall: packages/delete packages/install
	@exit 0

## Install packages 
packages/install:
	@if [ ! -d $(PACKAGES_PATH) ]; then \
	  echo "Installing packages $(PACKAGES_VERSION)..."; \
	  rm -rf $(PACKAGES_PATH); \
	  git clone -c advice.detachedHead=false --depth=1 -b $(PACKAGES_VERSION) https://github.com/cloudposse/packages.git $(PACKAGES_PATH); \
	  rm -rf $(PACKAGES_PATH)/.git; \
	fi

## Install package (e.g. helm, helmfile, kubectl)
packages/install/%: packages/install
	@make -C $(PACKAGES_PATH)/install $(subst packages/install/,,$@)

## Uninstall package (e.g. helm, helmfile, kubectl)
packages/uninstall/%: packages/install
	@make -C $(PACKAGES_PATH)/uninstall $(subst packages/uninstall/,,$@)
