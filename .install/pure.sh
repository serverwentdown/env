#!/bin/sh

set -e
source ./.versions

echo
echo "Installing pure-prompt for zsh..."
echo

mkdir -p ~/.zsh/functions
curl -fLo ~/.zsh/functions/prompt_pure_setup \
	https://raw.githubusercontent.com/sindresorhus/pure/master/pure.zsh
curl -fLo ~/.zsh/functions/async \
	https://raw.githubusercontent.com/sindresorhus/pure/master/async.zsh

