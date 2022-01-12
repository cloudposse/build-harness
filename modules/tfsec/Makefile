TFSEC ?= $(BUILD_HARNESS_PATH)/vendor/tfsec
TFSEC_VERSION ?= v0.63.1

## Install tfsec
tfsec/install: packages/install/tfsec
	@exit 0

## Static code security analysis
tfsec/run:
	$(TFSEC) .
