SHELL := /bin/bash
OS ?= $(shell uname -s | tr '[:upper:]' '[:lower:]')
SELF ?= make

.PHONY: jekyll\:install
# Install Jekyll
jekyll\:install:
	gem install jekyll jekyll-paginate jemoji html-proofer
	which jekyll

.PHONY: jekyll\:serve
## serve Jekyll
jekyll\:serve: ## serve Jekyll
	jekyll serve --watch --host "127.0.0.1" --baseurl ""

.PHONY: jekyll\:newpost
##
jekyll\:newpost:
	./scripts/newpost

.PHONY: jekyll\:generate-tags
##
jekyll\:generate-tags:
	./scripts/generate-tags

.PHONY: jekyll\:generate-categoris
##
jekyll\:generate-categories:
	./scripts/generate-categories

.PHONY: jekyll\:integrate-personal
##
jekyll\:integrate-personal:
	./scripts/integrate-personal

.PHONY: jekyll\:build
## Build Jekyll
jekyll\:build:
	jekyll build
