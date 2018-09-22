#!/bin/sh

set -e
source ./.versions

echo
echo "Installing Go $GOLANG_VERSION..."
echo


apk add --no-cache \
	git

apk add --no-cache --virtual .build-deps \
	bash \
	gcc \
	musl-dev \
	openssl \
	wget \
	tar \
	go

GOROOT_BOOTSTRAP="$(go env GOROOT)"
GOOS="$(go env GOOS)"
GOARCH="$(go env GOARCH)"
GOHOSTOS="$(go env GOHOSTOS)"
GOHOSTARCH="$(go env GOHOSTARCH)"

wget -O go.tgz "https://golang.org/dl/go$GOLANG_VERSION.src.tar.gz"

tar -C /usr/local -xzf go.tgz
rm go.tgz
cd /usr/local/go/src
./make.bash

# symlink into /usr/local/bin
ln -s /usr/local/go/bin/* /usr/local/bin/

apk del .build-deps

