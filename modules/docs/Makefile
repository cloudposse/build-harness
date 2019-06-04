.PHONY : docs
docs/deps::
	@mkdir -p docs

.PHONY : docs/targets.md
## Update `docs/targets.md` from `make help`
docs/targets.md: docs/deps
	@( \
		echo "## Makefile Targets"; \
		echo '```'; \
		$(SELF) --no-print-directory --quiet --silent $(DEFAULT_HELP_TARGET) | sed $$'s,\x1b\\[[0-9;]*[a-zA-Z],,g'; \
		echo '```'; \
	) > $@

.PHONY : docs/terraform.md
## Update `docs/terraform.md` from `terraform-docs`
docs/terraform.md: docs/deps packages/install/terraform-docs
	@$(BUILD_HARNESS_PATH)/bin/terraform-docs.sh md . > $@
