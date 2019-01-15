#!/bin/sh

set -e
source ./.versions

echo
echo "Installing yadm..."
echo

mkdir -p ~/.local/bin
curl -fLo ~/.local/bin/yadm https://github.com/TheLocehiliosan/yadm/raw/master/yadm
chmod a+x ~/.local/bin/yadm

