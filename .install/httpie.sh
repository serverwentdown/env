#!/bin/sh

set -e
source ./.versions

echo
echo "Installing HTTPie..."
echo

sudo apk add --no-cache \
	python3

pip3 install --user httpie

