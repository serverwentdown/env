#!/bin/sh

set -e
. "$(dirname "$0")"/../.versions

echo
echo "Installing HTTPie..."
echo

pip3 install --no-cache-dir --user httpie

