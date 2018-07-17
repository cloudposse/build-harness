CURL ?= curl
CHAMBER_VERSION ?= 2.0.0
CHAMBER ?= chamber

ifdef AWS_VAULT
	CHAMBER_AUTH = ""
else
	CHAMBER_AUTH = $(WITH_AWS)
endif

WITH_CHAMBER = $(CHAMBER_AUTH) chamber exec $(CHAMBER_SERVICES) --
CHAMBER_EXPORT = $(CHAMBER_AUTH) chamber export -f dotenv $(CHAMBER_SERVICES) | xargs -I{} echo " {}" | tr '\n' ' '

INJECT_CHAMBER ?= $(foreach var, IN_CHAMBER_MODE=true $(shell $(CHAMBER_EXPORT)), $(eval export $(var)))

## Install chamber
chamber/install: packages/install/chamber
	@exit 0

## Open secrets and run any commands with
chamber/shell: chamber/check-shell
	@if [ -z "${IN_CHAMBER_MODE}" ]; then \
		$(WITH_CHAMBER) bash --rcfile $(BUILD_HARNESS_PATH)/modules/chamber/chamber.bash.rc ; \
	else \
		bash --rcfile $(BUILD_HARNESS_PATH)/modules/chamber/chamber.bash.rc ; \
	fi;

# Ensure that variables required for chamber are set
chamber/check-shell: aws/check-shell
	$(call assert-set,CHAMBER_SERVICES)
