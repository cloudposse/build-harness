export GOMPLATE ?= $(BUILD_HARNESS_PATH)/vendor/gomplate

## Install dependencies
template/deps: packages/install/gomplate

## Create $OUT file by building it from $IN template file
template/build: template/deps
	@$(BUILD_HARNESS_PATH)/bin/template_generate.sh
