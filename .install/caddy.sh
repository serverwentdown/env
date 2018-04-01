#!/bin/sh

set -e
source ./.versions

echo
echo "Installing Caddy $CADDY_VERSION..."
echo

git clone https://github.com/mholt/caddy $(go env GOPATH)/src/github.com/mholt/caddy
cd $(go env GOPATH)/src/github.com/mholt/caddy/caddy
if [ "$CADDY_VERSION" = "master" ]; then
	git checkout $CADDY_VERSION
else
	git checkout v$CADDY_VERSION
fi
go get github.com/caddyserver/builds
go run build.go
go install
