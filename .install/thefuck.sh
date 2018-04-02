#!/bin/sh

set -e
source ./.versions

echo
echo "Installing thefuck for zsh..."
echo

apk add --no-cache --virtual .build-deps \
	build-base \
	python3-dev \
	linux-headers

apk add --no-cache \
	python3

pip3 install thefuck

apk del .build-deps
