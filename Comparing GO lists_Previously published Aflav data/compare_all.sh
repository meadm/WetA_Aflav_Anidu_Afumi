#!/bin/bash
#each file name is a variable
for FILE in /Users/MattMead/Documents/Work/Collaborations/Jae-Hyuk\ Yu/flavus_nidulans_fumigatus_wetA/GO_comparisons/FungiDB/fumigatus_nidulans*tab; do
#variable is the file name but without "fumigatus_nidulans"
	ALL=$(echo $FILE | sed 's/\/Users\/MattMead\/Documents\/Work\/Collaborations\/Jae-Hyuk\ Yu\/flavus_nidulans_fumigatus_wetA\/GO_comparisons\/FungiDB\/fumigatus_nidulans//')
#each line of the file is a variable	
	while read LINE; do
#cut the line so that only the ID is a variable		
		ID=$(echo $LINE | cut -d ' ' -f1,1)
#if the ID is name, do nothing	
		if grep -qw "$ID" /Users/MattMead/Documents/Work/Collaborations/Jae-Hyuk\ Yu/flavus_nidulans_fumigatus_wetA/GO_comparisons/Previous\ Aflavus\ Data\ and\ FungiDB/flavus_nidulans/flavus_nidulans$ALL; then
			awk -F\t -v OFS='\t' -v ID="$ID" '$1 == ID' /Users/MattMead/Documents/Work/Collaborations/Jae-Hyuk\ Yu/flavus_nidulans_fumigatus_wetA/GO_comparisons/Previous\ Aflavus\ Data\ and\ FungiDB/flavus_nidulans/flavus_nidulans$ALL >> all$ALL
		fi
	done < $FILE
done
