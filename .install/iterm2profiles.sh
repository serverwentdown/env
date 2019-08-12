#!/bin/sh

set -e
. ./.versions

echo
echo "Installing iTerm2 Profiles..."
echo

ln -s $HOME/.iterm2profiles.json Library/Application\ Support/iTerm2/DynamicProfiles/env.json
