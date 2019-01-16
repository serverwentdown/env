#!/bin/sh

set -e

echo
echo "Installing docker..."
echo 

apk add --no-cache \
	docker@community
#upx /usr/bin/docker{,d,-proxy}

