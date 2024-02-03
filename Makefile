# templates/Makefile.build-harness includes this Makefile
# and this Makefile includes templates/Makefile.build-harness
# to support different modes of invocation. Use a guard variable
# to prevent infinite recursive includes
ifeq ($(BUILD_HARNESS_TOP_LEVEL_MAKEFILE_GUARD),)
BUILD_HARNESS_TOP_LEVEL_MAKEFILE_GUARD := included

########################################################################################
## BEWARE: These variables are used by default by ALL PROJECTS that use Build Harness ##
##         See the section below for variables that are specific to this project      ##
########################################################################################

export OS := $(shell uname -s | tr '[:upper:]' '[:lower:]')
export BUILD_HARNESS_PATH ?= $(shell 'pwd')
export BUILD_HARNESS_EXTENSIONS_PATH ?= $(BUILD_HARNESS_PATH)/../build-harness-extensions
export BUILD_HARNESS_OS ?= $(OS)
export BUILD_HARNESS_ARCH ?= $(shell uname -m | sed 's/x86_64/amd64/g')
export SELF ?= $(MAKE)

# Forces auto-init off to avoid invoking the macro on recursive $(MAKE)
export BUILD_HARNESS_AUTO_INIT := false

# Debug should not be defaulted to a value because some cli consider any value as `true` (e.g. helm)
export DEBUG ?=


#############################################################################
## SAFE: These variables are used only when building build-harness itself, ##
##       so these are relatively safe to change                            ##
#############################################################################
ifeq ($(CURDIR),$(realpath $(BUILD_HARNESS_PATH)))
# Only execute this section if we're actually in the `build-harness` project itself
# List of targets the `readme` target should call before generating the readme
export README_DEPS ?= docs/targets.md auto-label
export DEFAULT_HELP_TARGET = help/all
# We do not have Alpine packages for arm64, so we need to force amd64 until we switch to Debian
export DOCKER_BUILD_FLAGS ?= --platform linux/amd64

auto-label: MODULES=$(filter %/, $(sort $(wildcard modules/*/)))
auto-label:
	for module in $(MODULES); do \
		echo "$${module%/}: $${module}**"; \
	done > .github/$@.yml

# builder/build is defined in templates/Makefile.build-harness
build: builder/build

else
export DOCKER_BUILD_FLAGS ?=
endif

# Import Makefiles into current context
include $(BUILD_HARNESS_PATH)/Makefile.*
include $(BUILD_HARNESS_PATH)/modules/*/bootstrap.Makefile*
include $(BUILD_HARNESS_PATH)/modules/*/Makefile*
include $(BUILD_HARNESS_PATH)/templates/Makefile.build-harness
# Don't fail if there are no build harness extensions
# Wildcard conditions is to fixes `make[1]: *** No rule to make target` error
ifneq ($(wildcard $(BUILD_HARNESS_EXTENSIONS_PATH)/modules/*/Makefile*),)
-include $(BUILD_HARNESS_EXTENSIONS_PATH)/modules/*/Makefile*
endif

# Unless PACKAGES_PREFER_HOST is not "false", add the PACKAGES_INSTALL_PATH, which
# is where build-harness installs needed tools, to the PATH, but wait
# until it is set, which may not be the first time through this Makefile.
# There is an incredibly subtle behavior here. Changes to PATH do not
# affect `make` itself, so $(shell ...) will not see the new PATH.
# Even more subtle, simple recipes that do not require a subshell,
# such as `kubectl version`, will NOT see the new PATH. To use binaries
# installed in the PACKAGES_INSTALL_PATH, you must use a recipe that forces a subshell,
# such as by using a pipe or compound command, or if nothing else is needed,
# using a no-op command such as `: && kubectl version`.
# To make things even more subtle, this is inconsistent across different
# versions of Gnu make, with disagreement about the correct behavior and
# bugs in the implementation. The above behavior is what we have observed
# with Gnu make 3.81, which is what Apple ships with macOS. Gnu make 4.4.1
# updates PATH everywhere. We suspect some versions in between update the
# PATH for recipes but not for $(shell ...).
# See:
# - https://savannah.gnu.org/bugs/?10593#comment5
# - https://savannah.gnu.org/bugs/?56834
ifneq ($(PACKAGES_INSTALL_PATH),)
export PATH := $(if $(subst false,,$(PACKAGES_PREFER_HOST)),$(PATH),$(PACKAGES_INSTALL_PATH):$(PATH))
endif

# For backwards compatibility with all of our other projects that use build-harness
init::
	exit 0

ifndef TRANSLATE_COLON_NOTATION
%:
	@$(SELF) -s $(subst :,/,$@) TRANSLATE_COLON_NOTATION=false
endif

endif
