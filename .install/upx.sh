#!/bin/sh

set -e
source ./.versions

echo
echo "Installing UPX..."
echo

apk add --no-cache \
	upx

