#!/bin/sh

set -e
. "$(dirname "$0")"/../.versions

echo
echo "Installing pure-prompt for zsh..."
echo

mkdir -p ~/.config/zsh/functions
curl -fLo ~/.config/zsh/functions/prompt_pure_setup \
	https://github.com/sindresorhus/pure/raw/v$PURE_VERSION/pure.zsh
curl -fLo ~/.config/zsh/functions/async \
	https://github.com/sindresorhus/pure/raw/v$PURE_VERSION/async.zsh

