#!/bin/bash
#for every file with a .tab file extension in the directory
for FILE in *tab; do
#make a variable that is the file name except .tab
	FNAME=$(echo $FILE | cut -d '.' -f1,1)
#read through every line one at a time	
	while read LINE; do
		#make variables that are each entry
		ID=$(echo $LINE | cut -d ' ' -f1,1)
		NAME=$(echo $LINE | cut -d ' ' -f2-)
#print the new header in the new file if the line is the old header		
		if [[ "$ID" == "GO" ]]; then
			echo ID"	"Name >> ${FNAME}2.tab
		else
#check to see if there are IDs that are already formatted correctly			
			GOCHECK=$(echo $LINE | cut -c 1-3 )
#if they are formatted correctly, print them in the new file				
				if [[ "$GOCHECK" == "GO:" ]]; then
					echo $ID"	"$NAME >> ${FNAME}2.tab
				else
#add "GO:" to the front of the ID					
					GOID=$(echo GO:${ID})
#count how many characters are in the new GO ID					
					GOIDCHECK=$(echo $GOID | wc -c )
#make a variable that is just 0					
					ZERO=$(echo 0)
#rename the ID to NEWID					
					NEWID=$(echo $ID)
#until there are 11 characters in the GOID...					
					until [ $GOIDCHECK == 11 ]; do
#add a 0 to the GO ID						
						GOID=$(echo GO:${ZERO}${NEWID})
						GOIDCHECK=$(echo $GOID | wc -c )
						NEWID=$(echo $GOID | cut -d ':' -f2,2)
					done
#when formatted properly, print the newly formatted line					
					echo $GOID"	"$NAME >> ${FNAME}2.tab
				fi
		fi
	done < $FILE
done
