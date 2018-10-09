#!/bin/sh

set -e

echo
echo "Installing neovim from repositories..."
echo 

apk add --no-cache \
	neovim@community
