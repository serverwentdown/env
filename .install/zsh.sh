#!/bin/sh

set -e
. "$(dirname "$0")"/../.versions

echo
echo "Installing zsh..."
echo

apk add --no-cache \
	zsh \
	coreutils

