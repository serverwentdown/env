#!/bin/bash

SPEED_FILE=/tmp/speedtest.log

if [[ "$1" == "speedtest" ]]; then
	echo "Testing..." > /tmp/speedtest.log
	OUTPUT="$(/usr/local/bin/speedtest --bytes --timeout 10 --simple)"
	echo "$OUTPUT" > /tmp/speedtest.log
	echo "Updated: $(date '+%a %l:%M:%S %p')" >> /tmp/speedtest.log
	osascript -e "display notification \"$OUTPUT\" with title \"BitBar Speedtest\"" &> /dev/null
	exit
fi

PING_ADDR=1.1.1.1
PING_STATS=$(ping -c 10 -i 0.1 $PING_ADDR | tail -n 2)

PING_NAMES=$(echo "$PING_STATS" | tail -n 1 | cut -d ' ' -f 2)
PING_TIMES=$(echo "$PING_STATS" | tail -n 1 | cut -d ' ' -f 4)

loss=$(echo "$PING_STATS" | head -n 1 | cut -d ' ' -f 7)
avg=$(echo $PING_TIMES | cut -d '/' -f 2 | tr -d $'\n')

printf "%.1fms %.0f%% | size=9\n" $avg ${loss%?}

echo ---

echo "address $PING_ADDR"

echo "loss $loss"

for i in {1..3}; do
	name=$(echo $PING_NAMES | cut -d '/' -f $i | tr -d $'\n')
	time=$(echo $PING_TIMES | cut -d '/' -f $i | tr -d $'\n')
	echo "$name ${time}ms"
done

echo ---

if [[ -f /tmp/speedtest.log ]]; then
	cat $SPEED_FILE
fi

echo "Run Speedtest | bash='$0' param1='speedtest' terminal=false refresh=true"
