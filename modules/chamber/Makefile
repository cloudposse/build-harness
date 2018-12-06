CURL ?= curl
CHAMBER_VERSION ?= 2.0.0
CHAMBER ?= chamber

ifdef AWS_VAULT
	CHAMBER_AUTH = ""
else
	CHAMBER_AUTH = $(WITH_AWS)
endif

WITH_CHAMBER = $(CHAMBER_AUTH) chamber exec $(CHAMBER_SERVICES) --

## Install chamber
chamber/install: packages/install/chamber
	@exit 0

## Start a chamber shell with secrets exported to the environment
chamber/shell: chamber/check-shell
	$(call assert-unset,IN_CHAMBER_MODE)
	@$(WITH_CHAMBER) bash --rcfile $(BUILD_HARNESS_PATH)/modules/chamber/chamber.bash.rc

# Ensure that variables required for chamber are set
chamber/check-shell: aws/check-shell
	$(call assert-set,CHAMBER_SERVICES)
