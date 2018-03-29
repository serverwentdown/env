#!/bin/sh

set -e
source .version

echo
echo "Installing vgo..."
echo

go get -u golang.org/x/vgo
