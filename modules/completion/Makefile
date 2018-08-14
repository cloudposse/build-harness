# Flag used to indicate if bash completion rules for make have already been installed
BASH_COMPLETION_FLAG ?= ~/.make.bash.completion

# Target to generate tab completion rules for bash
completion/bash:
	@$(SELF) -s $(DEFAULT_HELP_TARGET) | cut -d ' ' -f3  | sed 's/\x1b\[[0-9;]*m//g'

## Install completion script for bash
completion/install/bash:
	@[ -f $(BASH_COMPLETION_FLAG) ] || echo "complete -W \"\\\`[[ -f Makefile && -f .build-harness ]] && make completion/bash \\\`\" make" >> ~/.bashrc
	@touch $(BASH_COMPLETION_FLAG)
	@echo "Complete installed to .bashrc"
