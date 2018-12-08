#!/bin/sh

set -e
source ./.versions

echo
echo "Installing zsh-autosuggestions..."
echo

sudo apk add --no-cache --virtual .build-deps \
	git

git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
cd ~/.zsh/zsh-autosuggestions
git checkout v0.4.3

sudo apk del --no-cache .build-deps
