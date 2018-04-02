#!/bin/sh

set -e
source ./.versions

echo
echo "Installing pure-prompt for ZSH..."
echo

curl -fLo ~/.zfunctions/prompt_pure_setup --create-dirs \
	https://raw.githubusercontent.com/sindresorhus/pure/master/pure.zsh
curl -fLo ~/.zfunctions/async --create-dirs \
	https://raw.githubusercontent.com/sindresorhus/pure/master/async.zsh

