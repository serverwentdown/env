#!/bin/sh

set -e
. "$(dirname "$0")"/../.versions

echo
echo "Installing archival tools..."
echo

apk add --no-cache \
	unzip \
	zip \
	tar \
	gzip \
	xz

