SHELL := /bin/bash

HOST ?= 127.0.0.1
PORT ?= 4000
BASEURL ?=
SITE_URL ?= https://opticalendgame.jayd.ml
JEKYLL_ARGS ?=
PROOFER_SWAP := $(if $(BASEURL),--swap-urls '^$(BASEURL)/:/',)

.DEFAULT_GOAL := help

.PHONY: help setup install build check test dev clean

help: ## Show the available commands
	@awk 'BEGIN {FS = ":.*## "; printf "Usage: make <target>\n\n"} /^[a-zA-Z_-]+:.*## / {printf "  %-10s %s\n", $$1, $$2}' $(MAKEFILE_LIST)

setup: install ## Install all Ruby dependencies

install: ## Install gems into vendor/bundle
	bundle config set --local path vendor/bundle
	bundle install

build: ## Build the production site into _site/
	JEKYLL_ENV=production JEKYLL_SITE_URL="$(SITE_URL)" bundle exec jekyll build --trace --baseurl "$(BASEURL)" $(JEKYLL_ARGS)

check: build ## Build, then validate generated HTML and internal links
	bundle exec htmlproofer ./_site --disable-external --no-enforce-https $(PROOFER_SWAP)

test: check ## Alias for check

dev: ## Start the local server with live reload
	bundle exec jekyll serve --livereload --host $(HOST) --port $(PORT) $(JEKYLL_ARGS)

clean: ## Remove Jekyll's generated site and caches
	bundle exec jekyll clean
