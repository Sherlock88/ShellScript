#!/bin/bash

# Description:
#     Renames pictures taken out of camera
# Features:
#     (1) Adds a prefix
#     (2) Converts the extension to lower-case
#     (3) Uses a continous range of indices
#     (4) Logs old and new file names
# Usage:
#     rename.sh <prefix>
# Example:
#     Files: {DSC_0004.JPG, DSC_0006.JPG, DSC_0007.JPG}
#     Renamed files: {bangkok_0001.jpg, bangkok_0002.jpg, bangkok_0003.jpg}

ext=JPG
prefix=$1
if [ -z $prefix ]
then
	echo "Usage: rename.sh <prefix>"
	exit 1
fi
log=rename_log.txt
ext_upper=`echo $ext | tr '[:lower:]' '[:upper:]'`
ext_lower=`echo $ext | tr '[:upper:]' '[:lower:]'`

rm -f $log
cnt=1

for file in `ls -1 *.$ext_upper *.$ext_lower 2>/dev/null`
do
	index=`printf "%04d" $cnt`
	renamed_file=$prefix'_'$index.$ext_lower
	echo $file":"$renamed_file >> $log
	mv $file $renamed_file
	cnt=$((cnt+1))
done