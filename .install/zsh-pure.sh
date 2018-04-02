#!/bin/sh

set -e
source ./.versions

echo
echo "Installing pure-prompt for ZSH..."
echo

mkdir ~/.zfunctions
curl -fLo ~/.zfunctions/prompt_pure_setup https://raw.githubusercontent.com/sindresorhus/pure/master/pure.zsh
curl -fLo ~/.zfunctions/async https://raw.githubusercontent.com/sindresorhus/pure/master/async.zsh

echo '# pure' >> ~/.zshrc
echo 'fpath=( "$HOME/.zfunctions" $fpath )' >> ~/.zshrc
echo 'autoload -U promptinit; promptinit' >> ~/.zshrc
echo 'prompt pure' >> ~/.zshrc

