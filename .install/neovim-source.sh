#!/bin/sh

set -e
source ./.versions

echo
echo "Installing neovim $NEOVIM_VERSION..."
echo

apk add --no-cache \
	gettext \
	unibilium \
	libtermkey \
	libvterm \
	libgcc \
	python3 \
	clang-libs # For deoplete-clang

apk add --no-cache --virtual .build-deps \
	curl \
	git \
	unzip \
	build-base \
	autoconf \
	automake \
	cmake \
	libtool \
	gettext-dev \
	unibilium-dev \
	libtermkey-dev \
	libvterm-dev \
	python3-dev \
	python3

if [ "$NEOVIM_VERSION" = "nightly" ]; then
	branch=$NEOVIM_VERSION
else
	branch=v$NEOVIM_VERSION
fi
git clone --depth 1 -b $branch https://github.com/neovim/neovim.git
cd neovim
make CMAKE_EXTRA_FLAGS=-DENABLE_JEMALLOC=OFF >/dev/null || make
make install
cd ..
rm -rf neovim

pip3 install --no-cache-dir neovim

apk del --no-cache .build-deps
