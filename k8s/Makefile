all:
	@buildctl build --frontend=dockerfile.v0 --local dockerfile=. --local context=. --frontend-opt platform=linux/amd64,windows/amd64 --exporter=image --exporter-opt name=docker.io/ehazlett/kubelet

.PHONY: all
