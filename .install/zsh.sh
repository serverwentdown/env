#!/bin/sh

set -e
source ./.versions

echo
echo "Installing zsh..."
echo

apk add --no-cache \
	zsh \
	coreutils

