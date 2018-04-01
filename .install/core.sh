#!/bin/sh

set -e
source ./.versions

echo
echo "Installing system utilities..."
echo

apk add --no-cache \
	sudo \
	nano \
	curl \
	wget \
	openssh-client \
	unzip \
	zip \
	tar \
	xz

