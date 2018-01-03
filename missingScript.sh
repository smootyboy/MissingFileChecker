#!/bin/bash

#find /Volumes/CANON_DC/DCIM/100CANON/ -type f -exec basename {} \; | cut -d/ -f2- | sort > ~/file_list.txt

directory_path="/Volumes/Seagate Exp/foto archief/"
while read file_name; do 
	file_count=$(find "$directory_path" -name $file_name | wc -l)

	if [[ $file_count -lt 1 ]]; then
		file_path="/Volumes/CANON_DC/DCIM/100CANON/$file_name"
		rsync -azr "$file_path" "/Volumes/Seagate Exp/missing/"
	fi
done < file_list.txt