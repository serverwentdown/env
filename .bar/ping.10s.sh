#!/bin/bash

SPEED_FILE=/tmp/speedtest.log

if [[ "$1" == "speedtest" ]]; then
	speedtest --bytes --timeout 10 --simple > /tmp/speedtest.log
	echo "Updated: $(date +%H:%M:%S)" >> /tmp/speedtest.log
fi

PING_ADDR=twitter.com
PING_STATS=$(ping -c 10 -i 0.1 $PING_ADDR | tail -n 2)

PING_NAMES=$(echo "$PING_STATS" | tail -n 1 | cut -d ' ' -f 2)
PING_TIMES=$(echo "$PING_STATS" | tail -n 1 | cut -d ' ' -f 4)

loss=$(echo "$PING_STATS" | head -n 1 | cut -d ' ' -f 7)
avg=$(echo $PING_TIMES | cut -d '/' -f 2 | tr -d $'\n')

echo "${avg}ms $loss"

echo ---

echo "address $PING_ADDR"

echo "loss $LOSS"

for i in {1..3}; do
	name=$(echo $PING_NAMES | cut -d '/' -f $i | tr -d $'\n')
	time=$(echo $PING_TIMES | cut -d '/' -f $i | tr -d $'\n')
	echo "$name ${time}ms"
done

echo ---

if [[ -f /tmp/speedtest.log ]]; then
	cat $SPEED_FILE
fi

echo "Run speedtest | bash='./ping.10s.sh' param1='speedtest' terminal=false"
