export README_LINT ?= $(TMPDIR)/README.md
export README_FILE ?= README.md
export README_YAML ?= README.yaml
export README_TEMPLATE_FILE ?= $(BUILD_HARNESS_PATH)/templates/README.md
export README_TEMPLATE_YAML ?= $(BUILD_HARNESS_PATH)/templates/README.yaml

## Alias for readme/build
readme: readme/build
	@exit 0

## Create basic minimalistic .README.md template file
readme/init:
	@if [ -f $(README_YAML) ]; then \
	  echo "$(README_YAML) already exists!"; \
	else \
	  cp $(README_TEMPLATE_YAML) $(README_YAML) ; \
	  echo "$(README_YAML) created!"; \
	fi;

## Verify the `README.md` is up to date
readme/lint:
	@$(SELF) readme/build README_FILE=$(README_LINT) >/dev/null
	@diff -ruN $(README_LINT) $(README_FILE)
	@rm -f $(README_LINT)

## Create README.md by building it from README.yaml
readme/build:
	@mkdir -p docs
	@gomplate --file $(README_TEMPLATE_FILE) \
		--out $(README_FILE) \
		--datasource config=$(README_YAML) \
		--datasource=docs='file://$(shell pwd)/docs/?type=text/plain'
	@echo "Generated $(README_FILE) from $(README_TEMPLATE_FILE) using data from $(README_TEMPLATE_YAML)"
