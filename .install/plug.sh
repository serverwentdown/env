#!/bin/sh

set -e
source ./.versions

echo
echo "Installing vim-plug..."
echo

# avoid warnings and install spellcheck files first
curl -fLo ~/.local/share/nvim/site/spell/en.utf-8.spl --create-dirs \
	http://ftp.vim.org/pub/vim/runtime/spell/en.utf-8.spl
curl -fLo ~/.local/share/nvim/site/spell/en.utf-8.sug --create-dirs \
	http://ftp.vim.org/pub/vim/runtime/spell/en.utf-8.sug

# install plug
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
	https://github.com/junegunn/vim-plug/raw/$VIM_PLUG_VERSION/plug.vim

nvim +PlugInstall +qa || true

