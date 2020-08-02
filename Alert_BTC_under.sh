#!/bin/sh
threshold=$1
money=Bitcoin
interval=600		# Interval between checks in seconds
this=`basename $0 | sed 's/.sh//'`
[ $# -lt 1 ] && echo "Usage: ./$this <threshold>" && exit 1;
# Complete List is: lynx -dump 'https://tradingview.com/markets/cryptocurrencies/prices-all/' | awk '!/[0-9]\][A-Z]/{if ($NF ~ /\%$/) {print $0}}'
BT=`lynx -dump 'https://tradingview.com/markets/cryptocurrencies/prices-all/' | awk '!/[0-9]\][A-Z]/{if ($NF ~ /\%$/) {print $0}}' | head -1 | awk '{print int($3)}'`
echo "scale=2;$BT / $threshold" | bc
while [ $BT -gt $threshold ]; 
   do 
	date; 
	BT=`lynx -dump 'https://tradingview.com/markets/cryptocurrencies/prices-all/' | awk '!/[0-9]\][A-Z]/{if ($NF ~ /\%$/) {print $0}}' | head -1 | awk '{print int($3)}'`;
	banner $BT; 
	sleep $interval; 
   done; 
mailx -s $this_$BT your@email.com < /dev/null
