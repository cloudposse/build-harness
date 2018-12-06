export GOMPLATE ?= $(BUILD_HARNESS_PATH)/vendor/gomplate
GOMPLATE_VERSION ?= v2.6.0
GOMPLATE_REPO ?= hairyhenderson/gomplate

## Install dependencies
template/deps: packages/install/gomplate

## Create $OUT file by building it from $IN template file
template/build: template/deps
	@$(BUILD_HARNESS_PATH)/bin/template_generate.sh
