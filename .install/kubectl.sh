#!/bin/sh

set -e
source ./.versions

echo
echo "Installing kubectl $KUBECTL_VERSION..."
echo

apk add --no-cache --virtual .build-deps \
    curl

curl -fLo /usr/local/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/v$KUBECTL_VERSION/bin/linux/amd64/kubectl
chmod a+x /usr/local/bin/kubectl

apk del .build-deps
