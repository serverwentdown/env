#!/bin/sh

set -e
source ./.versions

echo
echo "Installing C/C++ compilers..."
echo

apk add --no-cache \
	alpine-sdk

