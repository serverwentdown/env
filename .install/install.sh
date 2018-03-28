#!/bin/sh

set -e

BASE_DIR="$(dirname $0)"
source ./.versions

for f in $BASE_DIR/*; do

	BASE_NAME="$(basename $f)"
	if [ "$BASE_NAME" = "install.sh" ]; then
		continue
	fi

	echo 
	echo "Running $BASE_NAME..."

	echo "$PWD"
	$f
	echo "$PWD"

done
