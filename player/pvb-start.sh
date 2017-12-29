#!/bin/bash

# open the setup app if device is not set
cd /home/pi/PVB/player
./clearall.sh
if [ ! -e ipaddress.txt ]; then
	./setup.sh
fi
# do a speed test, continue while the process is ongoing
speedtest > speedtest.txt

# register the device with the server
./checkregistry.sh

# get playlist and download the video files, continue while the process is ongoing
./getplaylistanddownload.sh &

# update status with the server every 10 minutes
./setstatus.sh
