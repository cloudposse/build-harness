.PHONY : docs
docs/deps::
	@mkdir -p docs

.PHONY : docs/targets.md
## Update `docs/targets.md` from `make help`
docs/targets.md: docs/deps
	@( \
		echo "<!-- markdownlint-disable -->"; \
		echo "## Makefile Targets"; \
		echo '```text'; \
		$(SELF) --no-print-directory --quiet --silent $(DEFAULT_HELP_TARGET) | sed $$'s,\x1b\\[[0-9;]*[a-zA-Z],,g'; \
		echo '```'; \
		echo "<!-- markdownlint-restore -->"; \
	) > $@

.PHONY : docs/terraform.md
## Update `docs/terraform.md` from `terraform-docs`
docs/terraform.md: docs/deps packages/install/terraform-docs
	@echo "<!-- markdownlint-disable -->" > $@ ; \
	terraform-docs md . >> $@ ; \
	echo "<!-- markdownlint-restore -->" >> $@

.PHONY : docs/github-action.md
## Update `docs/github-action.md` from `action.yaml`
docs/github-action.md: docs/deps packages/install/gomplate
	@echo "<!-- markdownlint-disable -->" > $@ ; \
	gomplate -d action=./action.yml -f $(BUILD_HARNESS_PATH)/templates/docs-github-action.gotmpl --config $(BUILD_HARNESS_PATH)/configs/gomplate.yaml >> $@ ; \
	echo "<!-- markdownlint-restore -->" >> $@

.PHONY : docs/github-actions-reusable-workflows.md
## Update `docs/github-actions-reusable-workflows.md` from `.github/workflows/*.yaml`
docs/github-actions-reusable-workflows.md: docs/deps packages/install/gomplate packages/install/yq
	@echo "<!-- markdownlint-disable -->" > $@
	@yq eval-all --exit-status --no-colors [.] ./.github/workflows/* | \
		gomplate -d workflows=stdin:?type=application/yaml -f $(BUILD_HARNESS_PATH)/templates/docs-github-actions-reusable-workflows.gotmpl --config $(BUILD_HARNESS_PATH)/configs/gomplate.yaml >> $@
	@echo "<!-- markdownlint-restore -->" >> $@
