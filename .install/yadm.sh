#!/bin/sh

set -e
source ./.versions

echo
echo "Installing yadm..."
echo

apk add --no-cache --virtual .build-deps \
	curl

apk add --no-cache \
	git \
	bash

curl -fLo /usr/local/bin/yadm https://github.com/TheLocehiliosan/yadm/raw/master/yadm
chmod a+x /usr/local/bin/yadm

apk del .build-deps
