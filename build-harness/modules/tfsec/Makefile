TFSEC ?= $(BUILD_HARNESS_PATH)/vendor/tfsec
TFSEC_VERSION ?= v0.63.1
# https://github.com/aquasecurity/tfsec/releases/download/v0.63.1/tfsec-linux-amd64
TFSEC_URL ?= https://github.com/aquasecurity/tfsec/releases/download/$(TFSEC_VERSION)/tfsec-$(OS)-$(BUILD_HARNESS_ARCH)

## Install tfsec
tfsec/install:
	@[ -x $(TFSEC) ] || ( \
		echo "Installing tfsec $(TFSEC_VERSION) ($(OS)) from $(TFSEC_URL)" && \
		curl '-#' -fL -o $(TMP)/tfsec $(TFSEC_URL) && \
		chmod +x $(TMP)/tfsec && \
		mv $(TMP)/tfsec $(TFSEC) && \
		rm -f $(TMP)/tfsec \
	)
	$(TFSEC) --version

## Static code security analysis
tfsec/run:
	$(TFSEC) .
