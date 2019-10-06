#!/bin/sh

set -e
. "$(dirname "$0")"/../.versions

echo
echo "Installing thefuck for zsh..."
echo

sudo apk add --no-cache --virtual .build-deps \
	build-base \
	python3-dev \
	linux-headers

pip3 install --no-cache-dir --user thefuck

sudo apk del --no-cache .build-deps
