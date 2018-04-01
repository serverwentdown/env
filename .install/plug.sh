#!/bin/sh

set -e
source ./.versions

echo
echo "Installing vim-plug..."
echo

curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

nvim +PlugInstall! +qa || true

