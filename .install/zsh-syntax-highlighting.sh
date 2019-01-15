#!/bin/sh

set -e
source ./.versions

echo
echo "Installing zsh-syntax-highlighting..."
echo

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting
cd ~/.zsh/zsh-syntax-highlighting
git checkout $ZSH_SYNTAX_HIGHLIGHTING_VERSION

