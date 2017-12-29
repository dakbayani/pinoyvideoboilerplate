#!/bin/bash
ipaddress=$(cat ipaddress.txt)
token=$(cat token.txt)
ls ./downloads > downloaddir.txt

# Loop after 20 hours
while :
do
	curl -X POST -d "function=getPlaylist&token=$token" $ipaddress:3010 > getplaylist.txt
	publicurl=$(cat getplaylist.txt | cut -d \" -f 14)
	movie1=$(cat getplaylist.txt | cut -d \" -f 24)
	movie2=$(cat getplaylist.txt | cut -d \" -f 26)
	movie3=$(cat getplaylist.txt | cut -d \" -f 28)
	movie4=$(cat getplaylist.txt | cut -d \" -f 30)
	movie5=$(cat getplaylist.txt | cut -d \" -f 32)
	movie6=$(cat getplaylist.txt | cut -d \" -f 34)
	movie7=$(cat getplaylist.txt | cut -d \" -f 36)
	movie8=$(cat getplaylist.txt | cut -d \" -f 38)
	movie9=$(cat getplaylist.txt | cut -d \" -f 40)
	movie10=$(cat getplaylist.txt | cut -d \" -f 42)
	if [ "$movie1" != "" ]; then
		echo $movie1.mp4 > playlist.txt
	fi
	if [ "$movie2" != "" ]; then
		echo $movie2.mp4 >> playlist.txt
	fi
	if [ "$movie3" != "" ]; then
		echo $movie3.mp4 >> playlist.txt
	fi
	if [ "$movie4" != "" ]; then
		echo $movie4.mp4 >> playlist.txt
	fi
	if [ "$movie5" != "" ]; then
		echo $movie5.mp4 >> playlist.txt
	fi
	if [ "$movie6" != "" ]; then
		echo $movie6.mp4 >> playlist.txt
	fi
	if [ "$movie7" != "" ]; then
		echo $movie7.mp4 >> playlist.txt
	fi
	if [ "$movie8" != "" ]; then
		echo $movie8.mp4 >> playlist.txt
	fi
	if [ "$movie9" != "" ]; then
		echo $movie9.mp4 >> playlist.txt
	fi
	if [ "$movie10" != "" ]; then
		echo $movie10.mp4 >> playlist.txt
	fi
	echo 0.mp4 >> playlist.txt
	
# remove exiting html files, then create and play video html based on playlist and availability
	./boilerplate.sh &

# Delete file if not in playlist
	numoffiles=$(wc -l < downloaddir.txt)
	numoffiles=$(($numoffiles))
	counter=1
	until [ $counter -gt $numoffiles ]
	do
		fileinspect=$(sed "${counter}q;d" downloaddir.txt)
		if [ "$(grep -w "$fileinspect" playlist.txt)" == "" ]; then
			rm -f ./downloads/$fileinspect
		fi
		((counter++))
	done
		
# download videos if they are not yet downloaded 
	filesinplaylist=$(wc -l < playlist.txt)
	filesinplaylist=$(($filesinplaylist))
	downloadcounter=1
	while [ $downloadcounter -le $filesinplaylist ]
	do
		downloadcandidate=$(sed "${downloadcounter}q;d" playlist.txt)
		if [ "$(grep -w "$downloadcandidate" downloaddir.txt)" == "" ]; then
			wget -O /home/pi/Downloads/$downloadcandidate $publicurl$downloadcandidate
			mv /home/pi/Downloads/$downloadcandidate ./downloads/$downloadcandidate
		fi
		((downloadcounter++))
	done
	sleep 72000
done