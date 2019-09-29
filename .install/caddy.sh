#!/bin/sh

set -e
source ./.versions

echo
echo "Installing Caddy $CADDY_VERSION..."
echo

if [ "$CADDY_VERSION" = "master" ]; then
	branch=$CADDY_VERSION
else
	branch=v$CADDY_VERSION
fi
git clone --depth 1 -b $branch https://github.com/caddyserver/caddy $(go env GOPATH)/src/github.com/caddyserver/caddy
export GO111MODULE=on
cd $(go env GOPATH)/src/github.com/caddyserver/caddy/caddy
go install
upx $(go env GOPATH)/bin/caddy
go clean -cache

