#!/bin/sh

set -e
source ./.versions

echo
echo "Installing minio-client..."
echo

sudo apk add --no-cache --virtual .build-deps \
	curl

mkdir -p  ~/.local/bin
curl -fLo ~/.local/bin/mc https://dl.minio.io/client/mc/release/linux-amd64/mc
chmod a+x ~/.local/bin/mc

sudo apk del .build-deps
