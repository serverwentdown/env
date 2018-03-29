#!/bin/sh

set -e
source .versions

echo
echo "Installing Python 3 with apk..."
echo

apk add --no-cache \
	python3

