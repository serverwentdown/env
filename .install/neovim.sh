#!/bin/sh

set -e
source ./.versions

echo
echo "Installing neovim..."
echo

apk add --no-cache --virtual .build-deps \
	git \
	alpine-sdk build-base \
	libtool \
	automake \
	m4 \
	autoconf \
	linux-headers \
	unzip \
	ncurses ncurses-dev ncurses-libs ncurses-terminfo \
	python3 \
	python3-dev \
	clang \
	go \
	xz \
	curl \
	make \
	cmake

git clone https://github.com/neovim/libtermkey.git
cd libtermkey
make
make install
cd ..
rm -rf libtermkey

git clone https://github.com/neovim/libvterm.git
cd libvterm
make
make install
cd ..
rm -rf libvterm

git clone https://github.com/neovim/unibilium.git 
cd unibilium 
make 
make install 
cd ..
rm -rf unibilium

git clone https://github.com/neovim/neovim.git
cd neovim
make
make install 
cd ..
rm -rf nvim

pip3 install neovim

apk del .build-deps
