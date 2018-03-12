export JENKINS_HOST ?= localhost
export JENKINS_URL ?= https://$(JENKINS_HOST)/buildByToken/buildWithParameters

# Depends on: https://wiki.jenkins-ci.org/display/JENKINS/Build+Token+Root+Plugin

## Run a Jenkins Job with $(TAG)
jenkins/run-job-with-tag:
	$(call assert-set,JENKINS_HOST)
	$(call assert-set,JENKINS_URL)
	$(call assert-set,TOKEN)
	$(call assert-set,JOB)
	$(call assert-set,TAG)
	@echo "Running $(JOB) on $(JENKINS_HOST) with tag $(TAG)..."
	@curl --fail '$(JENKINS_URL)' -d 'job=$(JOB)&token=$(TOKEN)&TAG=$(TAG)'
