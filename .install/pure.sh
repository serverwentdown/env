#!/bin/sh

set -e
source ./.versions

echo
echo "Installing pure-prompt for zsh..."
echo

sudo apk add --no-cache --virtual .build-deps \
	curl

mkdir -p ~/.zsh/functions
curl -fLo ~/.zsh/functions/prompt_pure_setup \
	https://raw.githubusercontent.com/sindresorhus/pure/master/pure.zsh
curl -fLo ~/.zsh/functions/async \
	https://raw.githubusercontent.com/sindresorhus/pure/master/async.zsh

sudo apk del --no-cache .build-deps
