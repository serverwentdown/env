#!/bin/sh

set -e
. "$(dirname "$0")"/../.versions

echo
echo "Installing gradlr..."
echo

yarn global add gradlr
