#!/bin/sh

set -e
source ./.versions

echo
echo "Installing packr..."
echo

source /etc/profile # add Go to PATH

go get -u github.com/gobuffalo/packr/...
