#!/bin/sh

set -e
source ./.versions

echo
echo "Installing pure-prompt for zsh..."
echo

mkdir -p ~/.zsh/functions
curl -fLo ~/.zsh/functions/prompt_pure_setup \
	https://github.com/sindresorhus/pure/raw/v$PURE_VERSION/pure.zsh
curl -fLo ~/.zsh/functions/async \
	https://github.com/sindresorhus/pure/raw/v$PURE_VERSION/async.zsh

