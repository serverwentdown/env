#!/bin/sh

set -e
source .version

echo
echo "Installing Python 3 with apk..."
echo

apk add --no-cache \
	python3

