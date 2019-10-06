#!/bin/sh

set -e
. "$(dirname "$0")"/../.versions

echo
echo "Installing system utilities..."
echo

apk add --no-cache \
	nano \
	curl \
	wget \
	bash \
	openssh-client

# bash for compatibility

