#!/bin/bash
serialno=$(cat serialno.txt)
ipaddress=$(cat ipaddress.txt)
curl -X POST -d "function=checkRegistry&device_id=$serialno" $ipaddress:3010 > devicereg.txt
devicereg=$(cat devicereg.txt | cut -d \" -f 6)
if [ "$devicereg" == "Device is registered and active." ]; then
	cat devicereg.txt | cut -d \" -f 10 > magnetlink.txt
	cat devicereg.txt | cut -d \" -f 18 > token.txt
fi
