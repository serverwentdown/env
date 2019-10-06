#!/bin/sh

set -e
. "$(dirname "$0")"/../.versions

echo
echo "Installing OpenJDK $JDK_NUMBER $JDK_VERSION..."
echo

apk add --no-cache --virtual .build-deps \
	curl \
	tar

#curl -fLo jdk.tar.gz https://download.java.net/java/GA/jdk$JDK_NUMBER/$JDK_VERSION/binaries/openjdk-${JDK_VERSION}_linux-x64_bin.tar.gz
curl -fLo jdk.tar.gz https://download.java.net/java/early_access/alpine/$JDK_VERSION/binaries/openjdk-$JDK_NUMBER-ea+${JDK_VERSION}_linux-x64-musl_bin.tar.gz
tar -C /usr/local -xzf jdk.tar.gz
ln -s /usr/local/jdk-$JDK_NUMBER /usr/local/jdk
rm jdk.tar.gz

# symlink into /usr/local/bin
ln -s /usr/local/jdk/bin/* /usr/local/bin/

apk del --no-cache .build-deps

