#!/bin/sh

set -e
source ./.versions

echo
echo "Installing sudo..."
echo

apk add --no-cache \
	sudo

echo '' >> /etc/sudoers
echo '## No password sudo' >> /etc/sudoers
echo 'ambrose ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

