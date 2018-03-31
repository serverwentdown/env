#!/bin/sh

set -e
source ./.versions

echo
echo "Installing Caddy $CADDY_VERSION..."
echo

source /etc/profile

git clone https://github.com/mholt/caddy -b "v$CADDY_VERSION" $(go env GOPATH)/src/github.com/mholt/caddy
cd $(go env GOPATH)/src/github.com/mholt/caddy/caddy
go get github.com/caddyserver/builds
go run build.go
go install
