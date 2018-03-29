#!/bin/sh

set -e
source .versions

echo
echo "Installing neovim..."
echo

echo "# TODO: Install from source"

apk add --no-cache --virtual .build-deps \
	curl \
	tar

#wget "https://github.com/neovim/neovim/releases/download/v$NEOVIM_VERSION/nvim-linux64.tar.gz"
#tar -C /usr/local -xzf nvim-linux64.tar.gz
#rm nvim-linux64.tar.gz
wget "https://github.com/neovim/neovim/releases/download/v$NEOVIM_VERSION/nvim.appimage"
mv nvim.appimage /usr/local/bin/nvim
chmod +x /usr/local/bin/nvim

apk del .build-deps
