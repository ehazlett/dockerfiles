FROM golang:1.7
RUN apt-get update && apt-get install -y --no-install-recommends \
    git make curl unzip autoconf automake libtool g++
RUN go get -u github.com/Masterminds/glide
RUN go get -u github.com/gogo/protobuf/proto
RUN go get -u github.com/gogo/protobuf/protoc-gen-gogo
RUN go get -u github.com/golang/protobuf/proto
RUN cd /tmp && git clone --depth=1 https://github.com/google/protobuf && \
    cd protobuf && \
    ./autogen.sh && \
    ./configure && \
    make && \
    make install && \
    ldconfig && \
    cd /tmp && rm -rf protobuf
