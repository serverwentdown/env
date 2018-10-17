#!/bin/sh

set -e

echo
echo "Downloading LS_COLORS..."
echo

wget https://raw.github.com/trapd00r/LS_COLORS/master/LS_COLORS -O ~/.dircolors
