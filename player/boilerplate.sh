#!/bin/bash
# do this process every hour
while : 
do 
# stop all videos and delete all html files first
	sudo killall chromium-browser &&
	rm -f *.html

# this creates the html files and plays them too
	publicurl=$(cat getplaylist.txt | cut -d \" -f 14)
	filesinplaylist=$(wc -l < playlist.txt)
	filesinplaylist=$(($filesinplaylist))
	endfilenumber=$(($filesinplaylist-1))
	downloadcounter=1
	downloadcounternext=2
	while [ $downloadcounter -le $endfilenumber ]
	do
		downloadcandidate=$(sed "${downloadcounter}q;d" playlist.txt)
		echo "<!DOCTYPE html>" > $downloadcounter.html
		echo "<html>" >> $downloadcounter.html
		echo "<head>" >> $downloadcounter.html
		echo  "<title>PVB</title>" >> $downloadcounter.html
		echo "<style>" >> $downloadcounter.html
		echo "video {" >> $downloadcounter.html
		echo "	position: absolute;" >> $downloadcounter.html
		echo "	top: 0;" >> $downloadcounter.html
		echo "	left: 0;" >> $downloadcounter.html
		echo "	width: 100%;" >> $downloadcounter.html
		echo "	height: 100%;" >> $downloadcounter.html
		echo "	overflow: hidden;" >> $downloadcounter.html
		echo "	object-fit: fill;" >> $downloadcounter.html
		echo "</style>" >> $downloadcounter.html
		echo "<script>" >> $downloadcounter.html
		echo "function nextVideo() {" >> $downloadcounter.html
		if [ "$downloadcounter" == "$endfilenumber" ]; then
			echo "	window.open("'"0.html"'", "'"_self"'");" >> $downloadcounter.html
		else
			echo "	window.open("\"$downloadcounternext.html"\", "'"_self"'");" >> $downloadcounter.html
		fi
		echo "}"  >> $downloadcounter.html
		echo "</script>" >> $downloadcounter.html
		echo "</head>" >> $downloadcounter.html
		echo "<body>" >> $downloadcounter.html
		echo "<center>" >> $downloadcounter.html
		echo "<video autoplay onended="'"nextVideo()"'" poster="'"PVB.jpg"'">" >> $downloadcounter.html
		if [ "$(grep -w "$downloadcandidate" downloaddir.txt)" == "" ]; then
			echo "	<source id="'"PVB"'" src="\"$publicurl$downloadcandidate"\" type="'"video/mp4"'">" >> $downloadcounter.html
		else
			echo "	<source id="'"PVB"'" src="\"./downloads/$downloadcandidate"\" type="'"video/mp4"'">" >> $downloadcounter.html
		fi
		echo "</video>" >> $downloadcounter.html
		echo "</center>" >> $downloadcounter.html
		echo "</body>" >> $downloadcounter.html
		echo "</html>" >> $downloadcounter.html
		((downloadcounter++))
		((downloadcounternext++))
	done
	echo "<!DOCTYPE html>" > 0.html
	echo "<html>" >> 0.html
	echo "<head>" >> 0.html
	echo "<title>PVB</title>" >> 0.html
	echo "<style>" >> 0.html
	echo "video {" >> 0.html
	echo "	position: absolute;" >> 0.html
	echo "	top: 0;" >> 0.html
	echo "	left: 0;" >> 0.html
	echo "	width: 100%;" >> 0.html
	echo "	height: 100%;" >> 0.html
	echo "	overflow: hidden;" >> 0.html
	echo "	object-fit: fill;" >> 0.html
	echo "</style>" >> 0.html
	echo "<script>" >> 0.html
	echo "function nextVideo() {" >> 0.html
	echo "	window.open("'"1.html"'", "'"_self"'");" >> 0.html
	echo "}"  >> 0.html
	echo "</script>" >> 0.html
	echo "</head>" >> 0.html
	echo "<body>" >> 0.html
	echo "<center>" >> 0.html
	if [ "$downloadcounter" == "1" ]; then
		echo "<video autoplay loop poster="'"PVB.jpg"'">" >> 0.html
	else
		echo "<video autoplay onended="'"nextVideo()"'" poster="'"logo.jpg"'">" >> 0.html
	fi
	echo "	<source id="'"islandliving"'" src="'"./downloads/0.mp4"'" type="'"video/mp4"'">" >> 0.html
	echo "</video>" >> 0.html
	echo "</center>" >> 0.html
	echo "</body>" >> 0.html
	echo "</html>" >> 0.html
	chromium-browser --kiosk 0.html &
	sleep 3600
	
done