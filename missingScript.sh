#!/bin/bash

if [[ "$#" -ne 4 ]] ; then
	echo "Usage: ./missingScript.sh originalDir destinationDir missingDir tmp"
	exit 1
fi

originalDir=$1 
destinationDir=$2
missingDir=$3
tmp=$4

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
if [ -e "$tmp" ]; then
    echo "$tmp already exists"
    read -p "Do you wish to overwrite? " -n 1 -r
	echo    
	if [[ $REPLY =~ ^[Yy]$ ]]
	then
    	echo "Continuing program"
	else
		exit 1
	fi
fi


find "$1" -type f | cut -d/ -f1- | sort > "$tmp"

while read file_path; do 
	echo "$file_path"
	file_name=${file_path##*/}
	found=false

	while read line; do
		#check hash
    	echo "Processing file $line against $file_path"
    	found=true
	done < <(find "$destinationDir" -name $file_name)

	echo "$found"
	if [ $found == true ] ; then
		echo "$found"
		continue
	fi

	rsync -azr "$file_path" "$missingDir"

done < "$tmp"

echo "Finished"