WORKFLOW_TEMPLATE_DIR ?= $(BUILD_HARNESS_PATH)/templates/github-automated-workflow

## Create new workflow
github-automated-workflow/init:
	@if [ -z $(name) ]; then echo -e "Required argument "name" not present\n"; exit 1; fi
	@$(eval WORKFLOW_NAME := $(shell echo "`date +"%Y-%m-%d"`-$(name)"))
	@if [ -d $(WORKFLOW_NAME) ]; then echo "Workflow named $(WORKFLOW_NAME) already exists"; exit 1; fi
	@mkdir -p $(WORKFLOW_NAME)
	@cp $(WORKFLOW_TEMPLATE_DIR)/workflow.yaml $(WORKFLOW_NAME)
	@sed -i '' -e "s/__NAME__/$(name)/" $(WORKFLOW_NAME)/workflow.yaml
	@echo "Workflow $(WORKFLOW_NAME) created."
	@echo "Update $(WORKFLOW_NAME)/workflow.yaml configuration file and run workflow with 'make github-automated-workflow/configure name=$(WORKFLOW_NAME)'"

# Create scripts based on yaml configuration
github-automated-workflow/configure:
	@if [ -z $(name) ]; then echo -e "Required argument "name" not present\n"; exit 1; fi
	@$(eval WORKFLOW_NAME := $(shell echo "$(name)"))
	@if [ ! -d $(WORKFLOW_NAME) ]; then echo "Workflow named $(WORKFLOW_NAME) does not exists"; exit 1; fi
	@cd $(name) && ln -fs $(BUILD_HARNESS_PATH)/bin/github-automated-workflow.py .
	@cd $(name) && gomplate --file $(WORKFLOW_TEMPLATE_DIR)/migration.sh.gotmpl --out migration.sh
	@cd $(name) && gomplate --file $(WORKFLOW_TEMPLATE_DIR)/pr-body.md.gotmpl --out pr-body.md
	@cd $(name) && chmod a+x migration.sh
	@mkdir -p $(name)/log
