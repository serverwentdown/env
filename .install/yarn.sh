#!/bin/sh

set -e
source ./.versions

echo
echo "Installing Yarn $YARN_VERSION..."
echo

sudo apk add --no-cache --virtual .build-deps-yarn \
	curl \
	gnupg \
	tar

for key in \
	6A010C5166006599AA17F08146C2130DFD2497F5 \
; do
	gpg --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys "$key" ||
	gpg --keyserver hkp://ipv4.pool.sks-keyservers.net --recv-keys "$key" ||
	gpg --keyserver hkp://pgp.mit.edu:80 --recv-keys "$key"
done

curl -fSLO --compressed "https://yarnpkg.com/downloads/$YARN_VERSION/yarn-v$YARN_VERSION.tar.gz"
curl -fSLO --compressed "https://yarnpkg.com/downloads/$YARN_VERSION/yarn-v$YARN_VERSION.tar.gz.asc"

gpg --batch --verify yarn-v$YARN_VERSION.tar.gz.asc yarn-v$YARN_VERSION.tar.gz
mkdir -p ~/.local/lib/
tar -xzf yarn-v$YARN_VERSION.tar.gz -C ~/.local/lib
ln -s ../lib/yarn-v$YARN_VERSION/bin/yarn ~/.local/bin/yarn
ln -s ../lib/yarn-v$YARN_VERSION/bin/yarnpkg ~/.local/bin/yarnpkg
rm yarn-v$YARN_VERSION.tar.gz.asc yarn-v$YARN_VERSION.tar.gz

sudo apk del .build-deps-yarn

