#!/bin/sh

set -e
source ./.versions

echo
echo "Installing zsh-syntax-highlighting..."
echo

git clone --depth 1 -b $ZSH_SYNTAX_HIGHLIGHTING_VERSION https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting
