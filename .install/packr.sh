#!/bin/sh

set -e
source ./.versions

echo
echo "Installing packr..."
echo

go get -u github.com/gobuffalo/packr/...
upx $(go env GOPATH)/bin/packr{,2}
go clean -cache

