#!/bin/sh

set -e
source ./.versions

echo
echo "Installing neovim..."
echo

apk add --no-cache --virtual .build-deps \
	curl \
	tar

echo "# TODO: Install from source"

apk del .build-deps
