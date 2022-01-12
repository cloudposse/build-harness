FLAKE8 ?= $(BUILD_HARNESS_PATH)/vendor/flake8
FLAKE8_VERSION ?= 4.0.1
FLAKE8_TARGET_PATH ?= $(BUILD_HARNESS_PATH)/vendor/.flake8

## Install flake8
flake8/install:
	@pip install --no-cache-dir --disable-pip-version-check --target $(FLAKE8_TARGET_PATH) flake8==$(FLAKE8_VERSION) && \
	ln -s $(FLAKE8_TARGET_PATH)/bin/flake8 $(FLAKE8)
	$(FLAKE8) --version
