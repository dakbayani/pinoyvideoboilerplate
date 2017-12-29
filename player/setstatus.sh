#!/bin/bash
./checkmonitorandnet.sh
ipaddress=$(cat ipaddress.txt)
token=$(cat token.txt)
monitorstatus=$(cat monitorstate.txt)                                                                                                                                                                                                                                                                                                                                                                                                                         
netspeed=$(cat netspeed.txt) 
curl -X POST -d "function=setStatus&token=$token&powered_on=1&in_use=$monitorstatus&internet_speed=$netspeed" $ipaddress:3010 > statusupdate.txt
