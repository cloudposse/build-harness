.PHONY : docs/targets.md
## Update `docs/targets.md` from `make help`
docs/targets.md:
	@( \
		echo "## Makefile Targets"; \
		echo '```'; \
		$(SELF) --no-print-directory --quiet --silent help | sed $$'s,\x1b\\[[0-9;]*[a-zA-Z],,g'; \
		echo '```'; \
	) > $@

.PHONY : docs/terraform.md
## Update `docs/terraform.md` from `terraform-docs`
docs/terraform.md: packages/install/terraform-docs
	@terraform-docs md . > $@
