export README_FILE ?= README.md
export README_TEMPLATE_FILE ?= .$(README_FILE)

## Alias for readme/build
readme: readme/build
	@exit 0

## Update table of contents in README.md
readme/toc-update:
	@doctoc --notitle --github $(README_FILE)

## Create basic minimalistic .README.md template file
readme/init:
	@if [ -s ./$(README_TEMPLATE_FILE) ]; then \
	  echo "$(README_TEMPLATE_FILE) already exists!"; \
	else \
	  cp $(BUILD_HARNESS_PATH)/templates/$(README_TEMPLATE_FILE) ./$(README_FILE) ; \
	  echo "$(README_FILE) created!"; \
	fi;

## Create README.md by building it from .README.md file
readme/build:
	@$(SELF) -s template/build IN=$(README_TEMPLATE_FILE) OUT=$(README_FILE)
