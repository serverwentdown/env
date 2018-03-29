#!/bin/sh

set -e
source ./.versions

echo
echo "Installing vgo..."
echo

go get -u golang.org/x/vgo
