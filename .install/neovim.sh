#!/bin/bash

set -e

echo
echo "Installing zsh with apk..."
echo

echo "# TODO: Install from source"

apk add --no-cache --virtual .build-deps \
	curl \
	tar

wget "https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.tar.gz"
tar -C /usr/local -xzf nvim-linux64.tar.gz
rm nvim-linux64.tar.gz
