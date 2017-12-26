export GOMPLATE ?= $(BUILD_HARNESS_PATH)/vendor/gomplate
GOMPLATE_VERSION ?= v2.2.0
GOMPLATE_REPO ?= hairyhenderson/gomplate


## Install dependencies
docs\:deps:
	@make github:download-public-release \
		REPO=$(GOMPLATE_REPO) \
		FILE=gomplate_$(OS)-amd64 \
		VERSION=$(GOMPLATE_VERSION) \
		OUTPUT=$(GOMPLATE) > /dev/null
	@chmod +x $(GOMPLATE)


.PHONY : docs\:build
## Create $OUT file by building it from $IN template file
docs\:build:
	@$(BUILD_HARNESS_PATH)/bin/doc_generate.sh
