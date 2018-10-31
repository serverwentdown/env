#!/bin/sh

set -e

echo
echo "Installing sway and dependencies..."
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
	rxvt-unicode \
	ttf-ubuntu-font-family \
	ttf-opensans@community

rc-update add udev
rc-update add dbus

apk add --no-cache \
	alsa-utils \
	alsa-utils-doc \
	alsa-lib \
	alsaconf \
	pulseaudio \
	pulseaudio-doc@community \
	pulseaudio-libs \
	pulseaudio-alsa@community

rc-update add alsa
