#!/bin/sh

set -e
source .versions

echo
echo "Installing zsh with apk..."
echo

apk add --no-cache \
	zsh

