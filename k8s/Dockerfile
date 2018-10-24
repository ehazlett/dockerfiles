FROM golang:1.11.1 as build
RUN git clone https://github.com/kubernetes/kubernetes /go/src/github.com/kubernetes/kubernetes
RUN apt-get update && apt-get install -y rsync

FROM build as windows
WORKDIR /go/src/github.com/kubernetes/kubernetes
ENV KUBE_BUILD_PLATFORMS=windows/amd64
ENV WHAT=cmd/kubelet
RUN make

FROM build as linux
WORKDIR /go/src/github.com/kubernetes/kubernetes
ENV KUBE_BUILD_PLATFORMS=linux/amd64
ENV WHAT=cmd/kubelet
RUN make

FROM scratch
COPY --from=windows /go/src/github.com/kubernetes/kubernetes/_output/local/bin/windows/amd64/kubelet.exe /bin/kubelet.exe
COPY --from=linux /go/src/github.com/kubernetes/kubernetes/_output/local/bin/linux/amd64/kubelet /bin/kubelet
