#!/bin/sh

set -e
source ./.versions

echo
echo "Installing Git..."
echo

apk add --no-cache \
	git

