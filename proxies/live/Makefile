SHELL := /bin/bash
dirname := $(notdir $(patsubst %/,%,$(CURDIR)))

list:
	@grep '^[^#[:space:]].*:' Makefile

build:
	rm -rf ../../build/proxies/$(dirname) || true
	mkdir -p ../../build/proxies/$(dirname)
	cp -r ./apiproxy ../../build/proxies/$(dirname)

deploy: build
	cd ../../build/proxies/$(dirname) && apigeetool deployproxy -V -o nhsd-nonprod -e internal-dev -n ord-api-test -t $$(get_token)

undeploy:
	apigeetool undeploy -V -o nhsd-nonprod -e internal-dev -n ord-api-test -t $$(get_token)

delete:
	apigeetool delete -V -o nhsd-nonprod -n ord-api-test -t $$(get_token)

clean:
	rm -rf ./node_modules
