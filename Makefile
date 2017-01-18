include Makefile.*

.PHONY : go
## This go tools
go:
	@make -C modules/$@

.PHONY : docs
## Operations with documentation
docs:
	@make -C modules/$@

.PHONY : docker
## Work with docker
docker:
	@make -C modules/$@