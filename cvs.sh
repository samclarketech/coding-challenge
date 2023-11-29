#!/bin/bash

# thought process/notes:

# iterate over the files in the containing dir
# take the filename and store in variable
# Brian\ Morris\ CV.docx - filename with escaped spaces
# make a unique dir
# unzip the docx to the unique dir
# grep contents of unique dir for "Engineer"
# if found return the filename
# send all unwanted output to /dev/null so that only the file names are returned
# unzip error to fix:
# unzip:  cannot find or open working/'Brian, working/'Brian.zip or working/'Brian.ZIP.

directory=working/*
dir_name=working

for file in $directory
do
	# split filename by the space, store each part in var
	filename1=$(echo $file | awk -F '/' '{print $2}' | cut -d' ' -f1)
	filename2=$(echo $file | awk -F '/' '{print $2}' | cut -d' ' -f2)
	filename3=$(echo $file | awk -F '/' '{print $2}' | cut -d' ' -f3)

	unique_dir=$(echo $file | awk -F '/' '{print $2}' | cut -d' ' -f1)

	filename=$filename1' '$filename2' '$filename3

	unzip $dir_name/$filename1\ $filename2\ $filename3 -d $dir_name/$unique_dir >/dev/null
	
	if grep -ri "engineer" $dir_name/$unique_dir >/dev/null
	then
		echo $filename
	fi
done
