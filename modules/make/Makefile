## Lint all makefiles
make/lint:
	@LINT=true \
	 find . -type f -name '*Makefile*' \
	  		-type f '!' -name '*.example' \
	  		-type f '!' -path './modules/packages/*' \
	  		-type f '!' -path './vendor/*' \
	  		-type f '!' -path './templates/Makefile.build-harness' \
	  		-type f '!' -path './Makefile' \
			-exec \
			 /bin/sh -c 'echo "==> {}">/dev/stderr; make --file=modules/packages/Makefile --include-dir=modules/ --just-print --dry-run --recon --no-print-directory --quiet --silent -f {}' \; > /dev/null
