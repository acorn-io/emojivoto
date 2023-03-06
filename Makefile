IMAGE_REPO ?= emojivoto
IMAGE_TAG ?= local

.PHONY: web emoji voting integration-tests push

all: build integration-tests

web:
	$(MAKE) -C cmd/web

compile-web:
	$(MAKE) -C cmd/web compile

emoji:
	$(MAKE) -C cmd/emoji

voting:
	$(MAKE) -C cmd/voting

compile: web emoji voting

%-image:
	docker build . -f ./cmd/$*/Dockerfile -t $(IMAGE_REPO):$*-$(IMAGE_TAG)

build-base:
	docker build . -f Dockerfile-base -t "$(IMAGE_REPO):emojivoto-base-$(IMAGE_TAG)"

images: build-base emoji-image voting-image web-image

local:
	acorn run -i . --request-rate 1

build:
	acorn build -t "$(IMAGE_REPO):$(IMAGE_TAG)" .

push:
	acorn push -t "$(IMAGE_REPO):$(IMAGE_TAG)"