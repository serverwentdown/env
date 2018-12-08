#!/bin/sh

set -e
source ./.versions

echo
echo "Installing zsh-autosuggestions..."
echo

sudo apk add --no-cache --virtual .build-deps \
	git

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting
cd ~/.zsh/zsh-syntax-highlighting
git checkout 0.6.0

sudo apk del --no-cache .build-deps
