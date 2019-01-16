#!/bin/sh

set -e
source ./.versions

echo
echo "Installing HTTPie..."
echo

pip3 install --no-cache-dir --user httpie

