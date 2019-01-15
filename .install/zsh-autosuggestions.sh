#!/bin/sh

set -e
source ./.versions

echo
echo "Installing zsh-autosuggestions..."
echo

git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
cd ~/.zsh/zsh-autosuggestions
git checkout v$ZSH_AUTOSUGGESTIONS_VERSION

