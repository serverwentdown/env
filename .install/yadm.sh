#!/bin/sh

set -e
source ./.versions

echo
echo "Installing yadm..."
echo

sudo apk add --no-cache --virtual .build-deps \
	curl

sudo apk add --no-cache \
	git \
	bash

curl -fLo ~/.local/bin/yadm https://github.com/TheLocehiliosan/yadm/raw/master/yadm
chmod a+x ~/.local/bin/yadm

sudo apk del .build-deps
