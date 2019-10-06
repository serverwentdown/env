#!/bin/sh

set -e
. "$(dirname "$0")"/../.versions

echo
echo "Installing Python 3 with apk..."
echo

apk add --no-cache \
	python3

