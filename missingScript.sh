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
if [ -e "$file" ]; then
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


find "$1" -type f -exec basename {} \; | cut -d/ -f2- | sort > "$tmp"

#directory_path="/Volumes/Seagate Exp/foto archief/"
while read file_name; do 
	file_count=$(find "$destinationDir" -name $file_name | wc -l)

	if [[ $file_count -lt 1 ]]; then
		file_path="$originalDir$file_name"
		rsync -azr "$file_path" "$missingDir"
	fi
done < "$tmp"