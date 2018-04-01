#!/bin/sh

set -e
source ./.versions

echo
echo "Installing vgo..."
echo

source /etc/profile # add Go to PATH

go get -u golang.org/x/vgo
