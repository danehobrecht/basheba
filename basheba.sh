#!/bin/bash

rclone mount --daemon google-drive: ~/google-drive/ 2> /dev/null
while true
do
	PLACES=$(find ~/.librewolf -type f -name "places.sqlite")
	cp $PLACES ~/Documents/Git/basheba/cache/places.sqlite
	cp ~/Documents/Git/basheba/cache/places.sqlite $PLACES
	sqlite3 -json ~/Documents/Git/basheba/cache/places.sqlite 'select * from moz_places' > ~/Documents/Git/basheba/cache/data.json
	jq '.[] | .url' ~/Documents/Git/basheba/cache/data.json > ~/Documents/Git/basheba/history.txt
	scp ~/Documents/Git/basheba/history.txt ~/google-drive/'Browsing History'/history.txt
	sleep 8
done