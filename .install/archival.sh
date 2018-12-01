#!/bin/sh

set -e
source ./.versions

echo
echo "Installing archival tools..."
echo

apk add --no-cache \
	unzip \
	zip \
	tar \
	gzip \
	xz

