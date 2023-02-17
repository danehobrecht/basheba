#!/bin/bash

echo 'Mounting...'
if rclone mount --daemon google-drive: ~/google-drive/; then
	echo 'Done'
fi

while true
do 
	result=$(find ~/.librewolf -type f -name "places.sqlite")
	sqlite3 -json $result 'select * from moz_places' > history.json
	echo 'Uploading...'
	scp history.json ~/google-drive/'Browsing History'/history.json
	echo 'Done'
	sleep 10
done