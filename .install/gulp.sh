#!/bin/sh

set -e
source ./.versions

echo
echo "Installing gulp..."
echo

yarn global add gulp-cli
