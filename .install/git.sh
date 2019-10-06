#!/bin/sh

set -e
. "$(dirname "$0")"/../.versions

echo
echo "Installing git..."
echo

apk add --no-cache \
	git \
	git-doc \
	less

# less to fix pager issues

