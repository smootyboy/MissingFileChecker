#!/bin/bash

if [[ "$#" -ne 3 ]] ; then
	echo "Usage: ./missingScript.sh originalDir destinationDir missingDir"
	exit 1
fi

originalDir=$1 
destinationDir=$2
missingDir=$3

if [ ! -d "$originalDir" ]; then
	echo "originalDir (arg 1) is not an existing directory"
	exit 1
fi
if [ ! -d "$destinationDir" ]; then
	echo "destinationDir (arg 2) is not an existing directory"
	exit 1
fi
if [ ! -d "$missingDir" ]; then
	echo "missingDir (arg 3) is not an existing directory"
	echo "creating missingDir"
	mkdir "$missingDir"
fi

while read file_path; do 
	file_name=${file_path##*/}
	found=false

	while read line; do

    	#echo "Checking hash of $line against $file_path"

    	if [ "$(md5sum "$line" | cut -d ' ' -f 1)" = "$(md5sum "$file_path" | cut -d ' ' -f 1)" ]; then
			found=true
		fi
	done < <(find "$destinationDir" -name $file_name)

	if [ $found == true ] ; then
		continue
	fi

	rsync -azr "$file_path" "$missingDir"

done < <(find "$1" -type f | cut -d/ -f1- | sort)

echo "Finished"