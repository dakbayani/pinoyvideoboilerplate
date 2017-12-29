#!/bin/bash
# this outputs 0 if hdmi is disconnected and 1 if connected
tvservice -s > tvservice.txt
if [ "$(grep -w "0x12000a" tvservice.txt)" == "" ]; then
	echo 0 > monitorstate.txt
else
	echo 1 > monitorstate.txt
fi
