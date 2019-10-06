#!/bin/sh

set -e
. "$(dirname "$0")"/../.versions

echo
echo "Installing kubectl $KUBECTL_VERSION..."
echo

mkdir -p ~/.local/bin
curl -fLo ~/.local/bin/kubectl \
	https://storage.googleapis.com/kubernetes-release/release/v$KUBECTL_VERSION/bin/linux/amd64/kubectl
chmod a+x ~/.local/bin/kubectl
upx ~/.local/bin/kubectl

