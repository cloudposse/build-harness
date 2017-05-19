export SHELL = /bin/bash
export BUILD_HARNESS_ORG ?= cloudposse
export BUILD_HARNESS_PROJECT ?= build-harness
export BUILD_HARNESS_BRANCH ?= master
export BUILD_HARNESS_PATH ?= $(shell until [ -d "$(BUILD_HARNESS_PROJECT)" ] || [ "`pwd`" == '/' ]; do cd ..; done; pwd)/$(BUILD_HARNESS_PROJECT)
-include $(BUILD_HARNESS_PATH)/Makefile

.PHONY : init
## Init build-harness
init::
	@curl --retry 5 --fail --silent --retry-delay 1 https://raw.githubusercontent.com/$(BUILD_HARNESS_ORG)/$(BUILD_HARNESS_PROJECT)/$(BUILD_HARNESS_BRANCH)/bin/install.sh | \
		bash -s "$(BUILD_HARNESS_ORG)" "$(BUILD_HARNESS_PROJECT)" "$(BUILD_HARNESS_BRANCH)"

.PHONY : clean
## Clean build-harness
clean::
	@[ "$(BUILD_HARNESS_PATH)" == '/' ] || \
	 [ "$(BUILD_HARNESS_PATH)" == '.' ] || \
	   echo rm -rf $(BUILD_HARNESS_PATH)
