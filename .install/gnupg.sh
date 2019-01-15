#!/bin/sh

set -e
source ./.versions

echo
echo "Installing GnuPG..."
echo

apk add --no-cache \
	gnupg

