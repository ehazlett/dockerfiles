FROM golang:1.9 as build
RUN apt-get update && apt-get install -y git ca-certificates build-essential
RUN cd / && git clone https://github.com/containernetworking/plugins && \
    cd plugins && bash build.sh

FROM scratch
COPY --from=build /plugins/bin/* /bin/
