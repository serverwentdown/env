#!/bin/sh

set -e

echo
echo "Installing sway..."
echo 

apk add --no-cache \
	dbus \
	eudev \
	libinput \
	xf86-video-intel \
	xorg-server-xwayland \
	sway@testing \
	sway-doc@testing \
	dmenu \
	xterm@community \
	ttf-ubuntu-font-family \
	ttf-opensans@community

