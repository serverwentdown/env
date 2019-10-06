#!/bin/sh

set -e
. "$(dirname "$0")"/../.versions

echo
echo "Installing GnuPG..."
echo

apk add --no-cache \
	gnupg

