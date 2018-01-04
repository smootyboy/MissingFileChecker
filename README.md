# MissingFileChecker

This little bash script checks if the files from one folder are also in another folder. This script works recursively through subfolders and does not require the same folder structure.

This script was inspired by the discovery that i was missing vacation photos in my backups from my digital camera. Unsure which photos were missing, I wanted all missing photos. However tools such as diff and rsync assume the same folder structure, and I had restructured my photo backups in separate years and occasions. This script allowed me to check what photos were on my camera but not in my backup and put them all in a folder for me to sort out where i wanted them in my backup.

## Usage:

./missingScript.sh originalDir destinationDir missingDir tmp

**originalDir**: The original directory containing all the files

**destinationDir**: The directory that may or may not hold all the same files as the original directory

**missingDir**: The directory that will hold all the files that are in the original directory but not in the destination directory

**tmp**: a file name used to store a list of all filenames in the original directory

## Mac users

Mac does not come with md5sum but has an similar tool build in md5. By adding ```alias md5sum='md5 -r'``` to your ~/.bashrc  or installing md5sum with homebrew ```brew install md5sha1sum``` this script will work.
