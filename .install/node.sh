#!/bin/sh

set -e

echo
echo "Installing nodejs from repositories..."
echo 

apk add --no-cache \
	nodejs@community

