#!/bin/sh

set -e
source .versions

echo
echo "Installing Go $GOLANG_VERSION..."
echo

apk add --no-cache --virtual .build-deps \
	bash \
	gcc \
	musl-dev \
	openssl \
	go

GOROOT_BOOTSTRAP="$(go env GOROOT)"
GOOS="$(go env GOOS)"
GOARCH="$(go env GOARCH)"
GOHOSTOS="$(go env GOHOSTOS)"
GOHOSTARCH="$(go env GOHOSTARCH)"

wget -O go.tgz "https://golang.org/dl/go$GOLANG_VERSION.src.tar.gz"

echo 'f3de49289405fda5fd1483a8fe6bd2fa5469e005fd567df64485c4fa000c7f24 *go.tgz' | sha256sum -c -
tar -C /usr/local -xzf go.tgz
rm go.tgz
cd /usr/local/go/src
./make.bash
apk del .build-deps

echo 'export GOPATH="$HOME/go"' >> /etc/profile.d/golang.sh
echo 'export PATH="$GOPATH/bin:/usr/local/go/bin:$PATH"' >> /etc/profile.d/golang.sh
