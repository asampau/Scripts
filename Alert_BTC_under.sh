#!/bin/sh
trishold=$1
money=Bitcoin
this=`basename $0 | sed 's/.sh//'`
[ $# -lt 1 ] && echo "Usage: ./$this <trishold>" && exit 1;
BT=`lynx -dump 'https://es.tradingview.com/markets/cryptocurrencies/prices-all/' | grep 'Bitcoin [0-9]' | awk '{print int($5)}'`
echo "scale=2;$BT / $trishold" | bc
while [ $BT -gt $trishold ]; 
   do 
	date; 
	BT=`lynx -dump 'https://es.tradingview.com/markets/cryptocurrencies/prices-all/' | grep 'Bitcoin [0-9]' | awk '{print int($5)}'`; 
	banner $BT; 
	sleep 600; 
   done; 
mailx -s $this_$BT asampau@gmail.com < /dev/null
