# MissingFileChecker

## Usage:

./missingScript.sh originalDir destinationDir missingDir tmp

originalDir: The original directory containing all the files

destinationDir: The directory that may or may not hold all the same files as the original directory

missingDir: The directory that will hold all the files that are in the original directory but not in the destination directory

tmp: a file name used to store a list of all filenames in the original directory

## Mac users

Mac does not come with md5sum but has an similar tool build in md5. By adding ```alias md5sum='md5 -r'``` to your ~/.bashrc  or installing md5sum with homebrew ```brew install md5sha1sum``` this script will work.
