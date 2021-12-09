SHELL := /bin/bash
########################################################################################################################
##
## Makefile for managing ord-api-cache
##
########################################################################################################################
compose_files = ${COMPOSE_FILES}
pwd := ${PWD}
dirname := $(notdir $(patsubst %/,%,$(CURDIR)))
proxies :=live

list:
	@grep '^[^#[:space:]].*:' Makefile

guard-%:
	@ if [ "${${*}}" = "" ]; then \
		echo "Environment variable $* not set"; \
		exit 1; \
	fi

clean-build:
	rm -rf ./build || true

clean-dist:
	rm -rf ./dist || true

clean: clean-build clean-dist

install:
	poetry install

reinstall: clean install

clean-reports:
	rm -rf ./reports || true

build: clean-build
	mkdir -p ./build
	for dir in $(proxies); do \
		make --no-print-directory -C proxies/$${dir} build & \
	done; \
	wait;

build-proxy: build

_dist_include="poetry.lock poetry.toml pyproject.toml Makefile build/."

dist: clean-dist build
	mkdir -p dist
	for f in $(_dist_include); do cp -r $$f dist; done

release: dist

pass:
	@echo ""

test: pass
lint: pass
check-licenses: pass
publish: pass


