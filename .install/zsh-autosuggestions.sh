#!/bin/sh

set -e
source ./.versions

echo
echo "Installing zsh-autosuggestions..."
echo

git clone --depth 1 -b v$ZSH_AUTOSUGGESTIONS_VERSION https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
