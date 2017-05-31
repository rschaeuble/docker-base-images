# Based on the Makefile from phusion/baseimage
NAME = rschaeuble/docker-base
VERSION = 0.0.1

ifdef REGISTRY
	FULLNAME=$(REGISTRY)/$(NAME)
else
	FULLNAME=$(NAME)
endif

.PHONY: all build test tag_latest release ssh

all: build

build: build-ubuntu

build-ubuntu:
	docker build -t $(FULLNAME):ubuntu-$(VERSION) -f Dockerfile.ubuntu .

test:
#	env NAME=$(FULLNAME) VERSION=$(VERSION) ./test/runner.sh

tag_latest: tag_latest-ubuntu

tag_latest-ubuntu:
	docker tag $(FULLNAME):ubuntu-$(VERSION) $(FULLNAME):ubuntu-latest

release: test tag_latest
	@if ! docker images $(FULLNAME) | awk '{ print $$2 }' | grep -q -F $(VERSION); then echo "$(FULLNAME) version $(VERSION) is not yet built. Please run 'make build'"; false; fi
	@if ! grep -q '## $(VERSION)' Changelog.md; then echo 'Please note the release in Changelog.md.' && false; fi
	echo docker push $(FULLNAME)
	@echo "*** Don't forget to create a tag. git tag rel-$(VERSION) && git push origin rel-$(VERSION)"
