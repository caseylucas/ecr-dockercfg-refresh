
IMAGE=ecr-dockercfg-refresh
TAG=0.1

.PHONY: build push

build:
	docker build -t caseylucas/$(IMAGE):$(TAG) .

push:
	docker push caseylucas/$(IMAGE):$(TAG)
