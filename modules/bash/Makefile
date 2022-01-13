## Lint all bash scripts
bash/lint:
	@set -o pipefail; \
	(find . -type f -name '*.sh'; \
	  grep -l -r '#!/bin/bash' .; \
	  grep -l -r '#!/usr/bin/env bash' .; \
	  grep -l -r '#!/bin/env bash' .) | grep -v 'Makefile' | sort -u | xargs -n 1 bash -n
