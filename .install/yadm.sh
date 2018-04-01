#!/bin/sh

set -e
source ./.versions

echo
echo "Installing yadm..."
echo

curl -fLo /usr/local/bin/yadm https://github.com/TheLocehiliosan/yadm/raw/master/yadm
chmod a+x /usr/local/bin/yadm
