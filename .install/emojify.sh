#!/bin/sh

set -e
. "$(dirname "$0")"/../.versions

echo
echo "Installing emojify..."
echo

mkdir -p ~/.local/bin
curl -fLo ~/.local/bin/emojify \
	https://raw.githubusercontent.com/mrowa44/emojify/master/emojify
chmod a+x ~/.local/bin/emojify


