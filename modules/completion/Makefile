BASH_COMPLETION_FLAG ?= ~/.make.bash.completion
BASH_COMPLETION_CACHE ?= .make.bash.completion

completion/bash:
	@if [ ! -f $(BASH_COMPLETION_CACHE) ] ; then \
		$(SELF) -s $(DEFAULT_HELP_TARGET) | cut -d ' ' -f3  | sed 's/\x1b\[[0-9;]*m//g' | tr '\n' ' ' > $(BASH_COMPLETION_CACHE); \
	fi;
	@cat $(BASH_COMPLETION_CACHE)

## Install completion script for bash
completion/install/bash:
	@[ -f $(BASH_COMPLETION_FLAG) ] || echo "complete -W \"\\\`[ -f Makefile ] && if [[ -f $(BASH_COMPLETION_CACHE) ]] ; then cat $(BASH_COMPLETION_CACHE); else make completion/bash; fi; \\\`\" make" >> ~/.bashrc
	@touch $(BASH_COMPLETION_FLAG)
	@echo "Complete installed to .bashrc"
