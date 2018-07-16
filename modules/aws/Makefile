export AWSCLI_VERSION ?= 1.11.185

WITH_AWS ?= aws-vault exec $(AWS_PROFILE) --

## Install aws cli bundle
aws/install:
	pip install --no-cache-dir --disable-pip-version-check awscli==$(AWSCLI_VERSION)

## Authorize on aws and run any commands with
aws/shell: aws/check-shell
	$(call assert-unset,AWS_VAULT)
	@$(WITH_AWS) bash --rcfile $(BUILD_HARNESS_PATH)/modules/aws/aws.bash.rc

aws/check-shell:
	$(call assert-set,AWS_PROFILE)



