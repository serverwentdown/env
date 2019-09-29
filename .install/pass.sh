#!/bin/sh

set -e

echo
echo "Installing pass..."
echo

sudo apk add --no-cache \
	gnupg \
	pass@testing
