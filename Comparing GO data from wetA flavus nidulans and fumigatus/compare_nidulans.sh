#!/bin/bash
#each file name is a variable
for FILE in *txt; do
#variable is the file name but without "fumigatus"	
	NIDULANS=$(echo $FILE | sed 's/flavus//')
#each line of the file is a variable	
	while read LINE; do
#cut the line so that only the ID is a variable		
		ID=$(echo $LINE | cut -d ' ' -f1,1)
#if the ID is name, do nothing	
		if [ "$ID" == "name" ]; then
			:
#if the ID is found in the nidulans file, print the id and the descriptor
		elif grep -qw "$ID" ../../nidulans\ RNAseq/BinGO/AspGD/nidulans$NIDULANS; then
			awk -F\t -v OFS='\t' -v ID="$ID" '$1 == ID {print $1,$2}' ../../nidulans\ RNAseq/BinGO/AspGD/nidulans$NIDULANS >> ../../GO_comparisons/flavus_nidulans$NIDULANS
		else
			:
		fi
	done < $FILE
done
