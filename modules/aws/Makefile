export AWSCLI_VERSION ?= 1.20.28

WITH_AWS ?= aws-vault exec $(AWS_PROFILE) --

## Install aws cli bundle
aws/install:
	pip install --no-cache-dir --disable-pip-version-check awscli==$(AWSCLI_VERSION)

## Start a aws-vault shell with access to aws api
aws/shell: aws/check-shell
	$(call assert-unset,AWS_VAULT)
	@$(WITH_AWS) bash --rcfile $(BUILD_HARNESS_PATH)/modules/aws/aws.bash.rc

# Ensure that variables required for aws-vault are set
aws/check-shell:
	$(call assert-set,AWS_PROFILE)



