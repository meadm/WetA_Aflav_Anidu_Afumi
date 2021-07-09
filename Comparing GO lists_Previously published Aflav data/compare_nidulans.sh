#!/bin/bash
#each file name is a variable
for FILE in ../flavus/cut*; do
#variable is the file name but without "flav"
	NIDULANS=$(echo $FILE | sed 's/..\/flavus\/cut_flav//')
#each line of the file is a variable	
	while read LINE; do
#cut the line so that only the GO ID is a variable
		GOID=$(echo $LINE | cut -d ' ' -f1,1)
#if the GO ID is ID, do nothing
		if [ "$GOID" == "ID" ]; then
			:
#if the ID is found in the nidulans file, print the id and the descriptor
		elif grep -qw "$GOID" /Users/MattMead/Documents/Work/Collaborations/Jae-Hyuk\ Yu/flavus_nidulans_fumigatus_wetA/nidulans\ RNAseq/FungiDB-based\ Analyses/GO/cut_nidu$NIDULANS; then
			awk -F\t -v OFS='\t' -v GOID="$GOID" '$1 == GOID {print $1,$2}' /Users/MattMead/Documents/Work/Collaborations/Jae-Hyuk\ Yu/flavus_nidulans_fumigatus_wetA/nidulans\ RNAseq/FungiDB-based\ Analyses/GO/cut_nidu$NIDULANS >> flavus_nidulans$NIDULANS
		else
			:
		fi
	done < $FILE
done
