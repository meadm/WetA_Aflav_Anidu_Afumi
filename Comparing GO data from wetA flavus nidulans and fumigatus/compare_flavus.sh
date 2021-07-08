#!/bin/bash
#each file name is a variable
for FILE in *txt; do
#variable is the file name but without "fumigatus"	
	FLAVUS=$(echo $FILE | sed 's/fumigatus//')
#each line of the file is a variable	
	while read LINE; do
#cut the line so that only the ID is a variable		
		ID=$(echo $LINE | cut -d ' ' -f1,1)
#if the ID is name, do nothing	
		if [ "$ID" == "name" ]; then
			:
#if the ID is found in the flavus file, print the id and the descriptor
		elif grep -qw "$ID" ../../flavus\ GO/AspGD\ Annotations/flavus$FLAVUS; then
#tells awk the input delimiter is tab, the output delimiter is tab, passes the ID variable to awk, if the first entry is ID then print both the ID and its annotation
			awk -F\t -v OFS='\t' -v ID="$ID" '$1 == ID {print $1,$2}' ../../flavus\ GO/AspGD\ Annotations/flavus$FLAVUS >> ../../GO_comparisons/fumigatus_flavus$FLAVUS
		else
			:
		fi
	done < $FILE
done
