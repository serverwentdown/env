#!/bin/sh

set -e
source ./.versions

echo
echo "Installing pure-prompt for ZSH..."
echo

curl -fLo /usr/local/share/zsh/site-functions/prompt_pure_setup --create-dirs \
	https://raw.githubusercontent.com/sindresorhus/pure/master/pure.zsh
curl -fLo /usr/local/share/zsh/site-functions/async --create-dirs \
	https://raw.githubusercontent.com/sindresorhus/pure/master/async.zsh

