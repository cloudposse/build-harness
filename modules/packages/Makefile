export INSTALL_PATH ?= $(BUILD_HARNESS_PATH)/vendor
export PACKAGES_VERSION ?= master
export PACKAGES_PATH ?= $(BUILD_HARNESS_PATH)/vendor/packages
export PACKAGES_PREFER_HOST ?= false

## Delete packages
packages/delete:
	rm -rf $(PACKAGES_PATH)

## Reinstall packages
packages/reinstall: packages/delete packages/install
	@exit 0

## Install packages 
packages/install:
	@if [ ! -d $(PACKAGES_PATH) ]; then \
		echo "* Installing packages $(PACKAGES_VERSION)..."; \
		rm -rf $(PACKAGES_PATH); \
		$(GIT) clone -c advice.detachedHead=false --depth=1 -b $(PACKAGES_VERSION) https://github.com/cloudposse/packages.git $(PACKAGES_PATH); \
		rm -rf $(PACKAGES_PATH)/.git; \
	fi 

## Install package (e.g. helm, helmfile, kubectl)
packages/install/%:
	@binary="$*"; \
	if [[ -x "$(INSTALL_PATH)/$$binary" ]]; then \
		echo "* Package $$binary already installed"; \
	elif [[ "$(PACKAGES_PREFER_HOST)" == "true" ]] && installed=$$(command -v $* 2>/dev/null); then \
		echo Using "$*" from "$$installed" ; \
	else \
		$(MAKE) packages/install && \
		echo "* Installing $* to $(INSTALL_PATH)" && \
		$(MAKE) -C $(PACKAGES_PATH)/install "$*"; \
	fi;

## Reinstall package (e.g. helm, helmfile, kubectl)
packages/reinstall/%: packages/install
	@$(MAKE) -C $(PACKAGES_PATH)/install $(subst packages/reinstall/,,$@)

## Uninstall package (e.g. helm, helmfile, kubectl)
packages/uninstall/%: packages/install
	@$(MAKE) -C $(PACKAGES_PATH)/uninstall $(subst packages/uninstall/,,$@)
