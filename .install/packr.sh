#!/bin/sh

set -e
source ./.versions

echo
echo "Installing packr..."
echo

go get github.com/gobuffalo/packr/v2/packr2
upx $(go env GOPATH)/bin/packr2
go clean -cache

