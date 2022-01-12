TFLINT ?= $(BUILD_HARNESS_PATH)/vendor/tflint
TFLINT_VERSION ?= 0.34.1

## Install tflint
tflint/install: packages/install/tflint
	@exit 0

## A Pluggable Terraform Linter
tflint/run:
	$(TFLINT) --init
	$(TFLINT) -f compact
