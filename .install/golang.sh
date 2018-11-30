#!/bin/sh

set -e

echo
echo "Installing Go from repositories..."
echo 

apk add --no-cache \
	git \
	go@community
