#!/bin/sh

set -e
. "$(dirname "$0")"/../.versions

echo
echo "Installing yadm..."
echo

mkdir -p ~/.local/bin
curl -fLo ~/.local/bin/yadm \
	https://github.com/TheLocehiliosan/yadm/raw/$YADM_VERSION/yadm
chmod a+x ~/.local/bin/yadm

