CGO_ENABLED=0
GOOS=linux
GOARCH=amd64
COMMIT=`git rev-parse --short HEAD`
PROJ?=ambassador
ORG?=ehazlett
TAG?=latest
UCP_VERSION?=$(shell cd ../../; make print-UCP_VERSION)

all: build-static image

build:
	@go build .

build-static:
	@go build -a -tags "netgo static_build" -installsuffix netgo .

image:
	@docker build -t $(ORG)/$(PROJ):$(TAG) .

clean:
	@rm proxy

push:
	$(DOCKER) push $(ORG)/$(PROJ):$(TAG)

.PHONY: build build-static image clean
