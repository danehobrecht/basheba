#!/bin/bash

printf 'Mounting...\t'
if rclone mount --daemon google-drive: ~/google-drive/; then
	printf 'Done'
fi

while true
do
	printf 'Locating...\t'
	if path=$(find ~/.librewolf -type f -name "places.sqlite"); then
		printf 'Done'
	fi
	printf '\nDuplicating...\t'
	if cp $path cache/places.sqlite; then
		printf 'Done'
	fi
	printf '\nOverwriting...\t'
	if cp cache/places.sqlite $path; then
		printf 'Done'
	fi
	printf '\nExtracting...\t'
	if sqlite3 -json cache/places.sqlite 'select * from moz_places' > cache/data.json; then
		printf 'Done'
	fi
	printf '\nParsing...\t'
	if jq '.[] | .url' cache/data.json > history.txt; then
		printf 'Done'
	fi
	printf '\nUploading...\t'
	if scp history.txt ~/google-drive/'Browsing History'/history.txt; then
		printf 'Done'
	fi
	printf '\nCycle complete!\n\n'
	sleep 8
done