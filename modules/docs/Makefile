GOMPLATE_VERSION ?= v2.2.0
GOMPLATE_REPO ?= hairyhenderson/gomplate
GOMPLATE ?= gomplate

## Install dependencies
docs\:deps:
	@make github:download-public-release \
		REPO=$(GOMPLATE_REPO) \
		FILE=$(GOMPLATE)_$(OS)-amd64 \
		VERSION=$(GOMPLATE_VERSION) \
		OUTPUT=/usr/local/bin/$(GOMPLATE) > /dev/null
	@chmod +x /usr/local/bin/$(GOMPLATE)



.PHONY : docs\:build
## Create $OUT file by building it from $IN template file
docs\:build:
	@BUILD_HARNESS_PATH=$(BUILD_HARNESS_PATH) \
		GOMPLATE=$(GOMPLATE) \
		$(BUILD_HARNESS_PATH)/bin/doc_generate.sh
