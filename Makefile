# Based on the Makefile from phusion/baseimage
NAME = rschaeuble/docker-base
VERSION = 0.0.1

.PHONY: all build test tag_latest release ssh

all: build

build: build-ubuntu

build-ubuntu:
	docker build -t $(NAME):ubuntu-$(VERSION) -f Dockerfile.ubuntu .

#test:
#	env NAME=$(NAME) VERSION=$(VERSION) ./test/runner.sh

tag_latest: tag_latest-ubuntu

tag_latest-ubuntu:
	docker tag $(NAME):ubuntu-$(VERSION) $(NAME):ubuntu-latest

#release: test tag_latest
#	@if ! docker images $(NAME) | awk '{ print $$2 }' | grep -q -F $(VERSION); then echo "$(NAME) version $(VERSION) is not yet built. Please run 'make build'"; false; fi
#	@if ! head -n 1 Changelog.md | grep -q 'release date'; then echo 'Please note the release date in Changelog.md.' && false; fi
#	docker push $(NAME)
#	@echo "*** Don't forget to create a tag. git tag rel-$(VERSION) && git push origin rel-$(VERSION)"
