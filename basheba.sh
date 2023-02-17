#!/bin/bash

echo 'Mounting...'
if rclone mount --daemon google-drive: ~/google-drive/; then
	echo 'Done'
fi

while true
do
	echo 'Locating...'
	if path=$(find ~/.librewolf -type f -name "places.sqlite"); then
		echo 'Done'
	fi
	echo 'Extracting...'
	if sqlite3 -json $path 'select * from moz_places' > data.json; then
		echo 'Done'
	fi
	echo 'Parsing...'
	if jq '.[] | .url' data.json > history.txt; then
		echo 'Done'
	fi
	echo 'Uploading...'
	if scp history.txt ~/google-drive/'Browsing History'/history.txt; then
		echo 'Done'
	fi
	sleep 30
done