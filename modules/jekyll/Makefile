SHELL := /bin/bash
OS ?= $(shell uname -s | tr '[:upper:]' '[:lower:]')
SELF ?= make

.PHONY: jekyll\:install
jekyll\:install:
	@gem install jekyll jekyll-paginate jemoji html-proofer
	@which jekyll

.PHONY: jekyll\:serve
jekyll\:serve:
	@jekyll serve --watch --host "127.0.0.1" --baseurl ""
	@curl -I https://127.0.0.1:4000

.PHONY: jekyll\:newpost
jekyll\:newpost:
	@bash <(curl "https://raw.githubusercontent.com/$(BUILD_MAKER_ORG)/$(BUILD_MAKER_PROJECT)/$(BUILD_MAKER_BRANCH)/modules/jekyll/scripts/newpost") >/dev/null

.PHONY: jekyll\:generate-tags
jekyll\:generate-tags:
	./scripts/generate-tags

.PHONY: jekyll\:generate-categoris
jekyll\:generate-categories:
	./scripts/generate-categories

.PHONY: jekyll\:integrate-personal
jekyll\:integrate-personal:
	./scripts/integrate-personal

.PHONY: jekyll\:build
jekyll\:build:
	@jekyll build
