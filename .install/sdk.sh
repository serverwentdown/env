#!/bin/sh

set -e
. "$(dirname "$0")"/../.versions

echo
echo "Installing C/C++ compilers..."
echo

apk add --no-cache \
	alpine-sdk

