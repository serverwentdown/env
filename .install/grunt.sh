#!/bin/sh

set -e
source ./.versions

echo
echo "Installing grunt..."
echo

yarn global add grunt-cli
