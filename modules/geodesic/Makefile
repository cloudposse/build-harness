## Run a Jenkins Job to Deploy $(APP) with $(CANONICAL_TAG)
geodesic/deploy:
	$(call assert-set,APP)
	@$(SELF) jenkins/run-job-with-tag \
		JOB=deploy-$(APP) \
		TAG=$(CANONICAL_TAG)
