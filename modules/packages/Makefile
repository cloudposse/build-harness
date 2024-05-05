export VENDOR_DIR ?= $(BUILD_HARNESS_PATH)/vendor
export VENDOR_SUBDIR := $(shell uname -s)/$(shell uname -m)
export PACKAGES_INSTALL_PATH ?= $(VENDOR_DIR)/$(VENDOR_SUBDIR)
export PACKAGES_VERSION ?= main
export PACKAGES_PATH ?= $(VENDOR_DIR)/packages
# PACKAGES_PREFER_HOST is used to force the use of the host's tools
# rather than the tools installed by build-harness in the git repo tree.
# This is to guard against the possibility that a malicious PR could install
# a compromised version of a tool that would be used by subsequent CI runs.
export PACKAGES_PREFER_HOST ?= false

## Delete local copy of packages repository
packages/delete:
	@# Do some checking to guard against running something like `rm -rf /` by mistake.
	@# Check if packages is a subdirectory of build-harness and is a valid directory before deleting it.
	@# Also, do not delete it if PRESERVE_PACKAGES is not empty.
	@# Use realpath to resolve symlinks and relative paths and compare the actual paths.
	@# Do not use realpath with [ -d ] because it returns an empty string if the path does not exist.
	@if [ -n "$(findstring $(realpath $(BUILD_HARNESS_PATH)),$(realpath $(PACKAGES_PATH)))" ] \
		&& [ ! "$(realpath $(BUILD_HARNESS_PATH))" = "$(realpath $(PACKAGES_PATH))" ] \
		&& [ -d "$(PACKAGES_PATH)" ] && [ -z "$(PRESERVE_PACKAGES)" ]; then \
		printf "* Removing existing packages cache under %s ...\n" "$(realpath $(PACKAGES_PATH))"; \
		rm -rf "$(realpath $(PACKAGES_PATH))"; \
	fi

## Reinstall local copy of packages repository
packages/reinstall: packages/delete packages/install
	@exit 0

# Set PRESERVE_PACKAGES to a non-empty value to preserve the packages cache if it is less than a day old
packages/install: PRESERVE_PACKAGES ?= $(shell [ -d "$(PACKAGES_PATH)" ] && find "$(PACKAGES_PATH)" -maxdepth 0 -mtime 0)
## Download packages repository
packages/install: packages/delete
	@if [ ! -d "$(PACKAGES_PATH)" ]; then \
		echo "* Installing packages $(PACKAGES_VERSION)..."; \
		$(GIT) clone -c advice.detachedHead=false --depth=1 -b $(PACKAGES_VERSION) https://github.com/cloudposse/packages.git "$(PACKAGES_PATH)"; \
		rm -rf "$(realpath $(PACKAGES_PATH))"/.git; \
	fi 

## Install package (e.g. helm, helmfile, kubectl)
packages/install/%: export INSTALL_PATH = $(PACKAGES_INSTALL_PATH)
packages/install/%:
	@binary="$*"; \
	if [ "$(PACKAGES_PREFER_HOST)" = "true" ]; then \
		if installed=$$(command -v $* 2>/dev/null); then \
			echo Using "$*" from "$$installed" ; \
		else \
			echo "* Package $$binary not found on the host" >&2; \
			echo "* NOT Installing $* because PACKAGES_PREFER_HOST is true" >&2; \
			exit 1; \
		fi; \
	elif [ -x "$(PACKAGES_INSTALL_PATH)/$$binary" ]; then \
		echo "* Package $$binary already installed"; \
	else \
		$(MAKE) packages/install && \
		echo "* Installing $* to $(PACKAGES_INSTALL_PATH)" && \
		$(MAKE) -C $(PACKAGES_PATH)/install "$*"; \
	fi;

## Reinstall package (e.g. helm, helmfile, kubectl)
packages/reinstall/%: export INSTALL_PATH = $(PACKAGES_INSTALL_PATH)
packages/reinstall/%: packages/install
	@$(MAKE) -C $(PACKAGES_PATH)/install $(subst packages/reinstall/,,$@)

## Uninstall package (e.g. helm, helmfile, kubectl)
packages/uninstall/%: export INSTALL_PATH = $(PACKAGES_INSTALL_PATH)
packages/uninstall/%: packages/install
	@$(MAKE) -C $(PACKAGES_PATH)/uninstall $(subst packages/uninstall/,,$@)
