#!/bin/bash

originalDir=$1 
echo "$1"
destinationDir=$2
echo "$2"
missingDir=$3
echo "$3"
tmp=$4
echo "$4"

find "$1" -type f -exec basename {} \; | cut -d/ -f2- | sort > "$tmp"

#directory_path="/Volumes/Seagate Exp/foto archief/"
while read file_name; do 
	file_count=$(find "$destinationDir" -name $file_name | wc -l)

	if [[ $file_count -lt 1 ]]; then
		file_path="$originalDir$file_name"
		rsync -azr "$file_path" "$missingDir"
	fi
done < "$tmp"