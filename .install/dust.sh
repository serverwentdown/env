#!/bin/sh

set -e
. "$(dirname "$0")"/../.versions

echo
echo "Installing dust $DUST_VERSION..."
echo

if [[ "$(uname -s)" == "Darwin" ]]; then
	os="apple-darwin"
else
	os="unknown-linux-gnu"
fi

curl -fSLO https://github.com/bootandy/dust/releases/download/v$DUST_VERSION/dust-v$DUST_VERSION-x86_64-$os.tar.gz

mkdir -p ~/.local/bin
tar -xzf dust-v$DUST_VERSION-x86_64-$os.tar.gz -C ~/.local/bin
upx ~/.local/bin/dust
rm dust-v$DUST_VERSION-x86_64-$os.tar.gz
