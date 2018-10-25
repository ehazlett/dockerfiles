FROM --platform=$BUILDPLATFORM golang:1.11.1 as build
ARG TARGETOS
ARG TARGETARCH
ENV GOOS=$TARGETOS GOARCH=$TARGETARCH
RUN apt-get update && apt-get install -y rsync
RUN git clone https://github.com/kubernetes/kubernetes /go/src/github.com/kubernetes/kubernetes
ENV KUBE_BUILD_PLATFORMS=$TARGETOS/$TARGETARCH
ENV WHAT=cmd/kubelet
WORKDIR /go/src/github.com/kubernetes/kubernetes
RUN make

FROM build as release-img-linux
COPY --from=build /go/src/github.com/kubernetes/kubernetes/_output/local/bin/linux/amd64/kubelet /bin/
ENTRYPOINT ["/kubelet"]

FROM microsoft/nanoserver:latest as release-img-windows
COPY --from=build /go/src/github.com/kubernetes/kubernetes/_output/local/bin/windows/amd64/kubelet.exe /
ENTRYPOINT ["C:\\Files\\kubelet.exe"]

FROM release-img-$TARGETOS
