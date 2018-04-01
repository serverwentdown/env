#!/bin/sh

set -e
source ./.versions

echo
echo "Installing neovim $NEOVIM_VERSION..."
echo

apk add --no-cache --virtual .build-deps \
	curl \
	git \
	unzip \
	build-base \
	autoconf \
	automake \
	cmake \
	libtool \
	unibilium-dev \
	libtermkey-dev \
	libvterm-dev \
	python3

git clone https://github.com/neovim/neovim.git
cd neovim
if [ "$NEOVIM_VERSION" = "nightly" ]; then
	git checkout $NEOVIM_VERSION
else
	git checkout v$NEOVIM_VERSION
fi
if [ "$NEOVIM_VERSION" = "0.2.2" ]; then
	# temp fix for #8056 until next release
	sed -i 's/https:\/\/raw\.githubusercontent\.com\/mpeterv\/luacheck\/master\/luacheck-scm-1\.rockspec/https:\/\/luarocks\.org\/manifests\/mpeterv\/luacheck-0\.21\.2-1\.rockspec/g' third-party/cmake/BuildLuarocks.cmake
fi
make CMAKE_EXTRA_FLAGS=-DENABLE_JEMALLOC=OFF
make install
cd ..
rm -rf neovim

pip3 install neovim

apk del .build-deps
