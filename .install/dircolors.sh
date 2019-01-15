#!/bin/sh

set -e

echo
echo "Downloading LS_COLORS..."
echo

curl -fLo ~/.dircolors \
	https://github.com/trapd00r/LS_COLORS/raw/master/LS_COLORS
