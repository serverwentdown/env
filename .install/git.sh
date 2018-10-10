#!/bin/sh

set -e
source ./.versions

echo
echo "Installing git..."
echo

apk add --no-cache \
	git \
	git-doc \
	less

# less to fix pager issues

