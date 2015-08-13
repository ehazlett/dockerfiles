CGO_ENABLED=0
GOOS=linux
GOARCH=amd64
REPO=ehazlett/docker-install

all: build image

build:
	@go build -a -tags "netgo static_build" -installsuffix netgo .

image: build
	@docker build -t $(REPO):$(TAG) .

.PHONY: all build image
