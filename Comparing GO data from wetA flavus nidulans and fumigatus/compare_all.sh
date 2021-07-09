#!/bin/bash
#each file name is a variable
for FILE in fumigatus_flavus*txt; do
#variable is the file name but without "fumigatus"	
	ALL=$(echo $FILE | sed 's/fumigatus_flavus//')
#each line of the file is a variable	
	while read LINE; do
#cut the line so that only the ID is a variable		
		ID=$(echo $LINE | cut -d ' ' -f1,1)
#if the ID is name, do nothing	
		if grep -qw "$ID" flavus_nidulans$ALL; then
			awk -F\t -v OFS='\t' -v ID="$ID" '$1 == ID' flavus_nidulans$ALL >> All_3/all$ALL
		fi
	done < $FILE
done
