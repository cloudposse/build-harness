BASH_COMPLETION_FLAG ?= ~/.make.bash.completion

completion:
	@if [ ! -f .build-harness.completion ] ; then \
		$(SELF) -s $(DEFAULT_HELP_TARGET) | cut -d ' ' -f3  | sed 's/\x1b\[[0-9;]*m//g' | tr '\n' ' ' > .build-harness.completion; \
	fi;
	@cat .build-harness.completion

## Install completion script for bash
completion/install/bash:
	@[ -f $(BASH_COMPLETION_FLAG) ] || echo "complete -W \"\\\`[ -f Makefile ] && if [[ -f .build-harness.completion ]] ; then cat ./.build-harness.completion; else make completion; fi; \\\`\" make" >> ~/.bashrc
	@touch $(BASH_COMPLETION_FLAG)
	@echo "Complete installed to .bashrc"