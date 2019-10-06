#!/bin/sh

set -e
. "$(dirname "$0")"/../.versions

echo
echo "Installing jq $JQ_VERSION..."
echo

mkdir -p ~/.local/bin
curl -fLo ~/.local/bin/jq \
	https://github.com/stedolan/jq/releases/download/jq-$JQ_VERSION/jq-linux64
chmod a+x ~/.local/bin/jq
upx ~/.local/bin/jq

