#!/bin/sh

set -e
source .version

echo
echo "Installing zsh with apk..."
echo

apk add --no-cache \
	zsh

