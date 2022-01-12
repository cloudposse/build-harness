CHECKOV ?= $(BUILD_HARNESS_PATH)/vendor/checkov
CHECKOV_VERSION ?= 2.0.701
CHECKOV_TARGET_PATH ?= $(BUILD_HARNESS_PATH)/vendor/.checkov

## Install checkov
checkov/install:
	@[ -x $(CHECKOV) ] || ( \
		echo "Installing checkov $(CHECKOV_VERSION) ($(OS)) from pip" && \
		pip install --no-cache-dir --disable-pip-version-check --target $(CHECKOV_TARGET_PATH) checkov==$(CHECKOV_VERSION) && \
		ln -f -s $(CHECKOV_TARGET_PATH)/bin/checkov $(BUILD_HARNESS_PATH)/vendor/ \
	)
	$(CHECKOV) --version

## Static code security analysis
checkov/run:
	@if [[ -e $(TERRAFORM_INFRA_DIR)/$(TERRAFORM_TFVARS) ]]; then \
		echo "* tfvars file found" && \
		LOG_LEVEL=error checkov --directory=$(TERRAFORM_INFRA_DIR) --quiet --var-file=$(TERRAFORM_INFRA_DIR)/$(TERRAFORM_TFVARS) --download-external-modules=false --framework=terraform ; \
	else \
		echo "* Unable to locate tfvars"; \
	fi
