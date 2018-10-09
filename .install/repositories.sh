#!/bin/sh

set -e

echo
echo "Setting up repositories..."
echo

cat >> /etc/apk/repositories << EOF
@edge http://dl-cdn.alpinelinux.org/alpine/edge/main
@community http://dl-cdn.alpinelinux.org/alpine/edge/community
@testing http://dl-cdn.alpinelinux.org/alpine/edge/testing
EOF
