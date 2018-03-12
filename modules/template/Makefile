export GOMPLATE ?= $(BUILD_HARNESS_PATH)/vendor/gomplate
GOMPLATE_VERSION ?= v2.2.0
GOMPLATE_REPO ?= hairyhenderson/gomplate


## Install dependencies
template\:deps:
	@make github:download-public-release \
		REPO=$(GOMPLATE_REPO) \
		FILE=gomplate_$(OS)-amd64 \
		VERSION=$(GOMPLATE_VERSION) \
		OUTPUT=$(GOMPLATE) > /dev/null
	@chmod +x $(GOMPLATE)


.PHONY : template\:build
## Create $OUT file by building it from $IN template file
template\:build:
	@$(BUILD_HARNESS_PATH)/bin/template_generate.sh
