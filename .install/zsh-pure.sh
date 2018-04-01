#!/bin/sh

set -e
source ./.versions

echo
echo "Installing pure-prompt for ZSH..."
echo

yarn global add pure-prompt
