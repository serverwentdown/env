#!/bin/sh

set -e
. ./.versions

echo
echo "Installing iTerm2 Profiles..."
echo

if ! [[ "$(uname -s)" == "Darwin" ]]; then
	echo "Not supported on Linux"
	exit 1
fi

ln -s $HOME/.config/iterm2profiles.json Library/Application\ Support/iTerm2/DynamicProfiles/env.json

