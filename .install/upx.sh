#!/bin/sh

set -e
. "$(dirname "$0")"/../.versions

echo
echo "Installing UPX..."
echo

apk add --no-cache \
	upx

