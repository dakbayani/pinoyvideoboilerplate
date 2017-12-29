#!/bin/bash
while :
do
	gpio mode 1 in
	gpio read 1 > powermode.txt
	sleep 60
	if [ "$(cat powermode.txt)" == "0" ]; then
		sudo killall chromium-browser
		sleep 10
		sudo poweroff
	else
		sleep 60
	fi
done 
