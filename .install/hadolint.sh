#!/bin/sh

set -e
. "$(dirname "$0")"/../.versions

echo
echo "Installing hadolint $HADOLINT_VERSION..."
echo

if [[ "$(uname -s)" == "Darwin" ]]; then
	os="Darwin"
else
	os="Linux"
fi

mkdir -p ~/.local/bin
curl -fLo ~/.local/bin/hadolint \
	https://github.com/hadolint/hadolint/releases/download/v$HADOLINT_VERSION/hadolint-$os-x86_64
chmod a+x ~/.local/bin/hadolint

