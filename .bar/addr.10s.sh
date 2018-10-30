#!/bin/bash

ACTIVE_INTERFACE=$(route get 1.1.1.1 | grep interface | cut -d ' ' -f 4)

ADDR=$(ifconfig $ACTIVE_INTERFACE | grep 'inet ' | cut -d ' ' -f 2)
ADDR6=$(ifconfig $ACTIVE_INTERFACE | grep 'inet6 ' | grep -v 'fe80' | cut -d ' ' -f 2)

echo $ADDR

echo ---

for iface in $(ifconfig -lu); do
	IFCONFIG_OUTPUT=$(ifconfig $iface)
	echo "iface $iface"
	echo "$IFCONFIG_OUTPUT" | grep ether | sed -e 's/^[[:space:]]*//'
	echo "$IFCONFIG_OUTPUT" | grep 'inet ' | sed -e 's/^[[:space:]]*//'
	echo "$IFCONFIG_OUTPUT" | grep 'inet6 ' | grep -v 'fe80' | sed -e 's/^[[:space:]]*//'
	echo ---
done

