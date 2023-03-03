IMAGE_REPO ?= emojivoto
IMAGE_TAG ?= local

.PHONY: web emoji-svc voting-svc integration-tests push

all: build integration-tests

web:
	$(MAKE) -C emojivoto-web

compile-web:
	$(MAKE) -C emojivoto-web compile

emoji-svc:
	$(MAKE) -C emojivoto-emoji-svc

voting-svc:
	$(MAKE) -C emojivoto-voting-svc

build: build-base-docker-image web emoji-svc voting-svc

%-image:
	docker build . -f ./emojivoto-$*/Dockerfile -t $(IMAGE_REPO):emojivoto-$*-$(IMAGE_TAG)

build-base:
	docker build . -f Dockerfile-base -t "$(IMAGE_REPO):emojivoto-svc-base-$(IMAGE_TAG)"

images: build-base emoji-svc-image voting-svc-image web-image

push-%:
	docker push $(IMAGE_REPO):emojivoto-$*-$(IMAGE_TAG)

push: push-svc-base push-emoji-svc push-voting-svc push-web

local:
	acorn run -i