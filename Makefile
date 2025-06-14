PROJECT_NAME := lerax
VERSION := latest
DOCKER_IMG := ryukinix/$(PROJECT_NAME)
DOCKER_REGISTRY := docker.io
REGISTRY_IMG := $(DOCKER_REGISTRY)/$(DOCKER_IMG)
EXTRA_PACKAGES :=

build:
	docker build --build-arg EXTRA_PACKAGES=$(EXTRA_PACKAGES) -t $(DOCKER_IMG) .

publish: build
	docker tag $(DOCKER_IMG) $(REGISTRY_IMG):$(VERSION)
	docker push $(REGISTRY_IMG):$(VERSION)

publish-tex:
	$(MAKE) publish VERSION=tex EXTRA_PACKAGES=texlive-full
