#!/bin/sh

set -e

echo
echo "Installing firefox..."
echo 

apk add --no-cache \
	firefox@testing
