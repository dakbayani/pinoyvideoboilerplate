#!/bin/bash
./monitor-on.sh
a=$(grep -w "Download" speedtest.txt | cut -d \  -f 2)
echo $a"MBPS" > netspeed.txt