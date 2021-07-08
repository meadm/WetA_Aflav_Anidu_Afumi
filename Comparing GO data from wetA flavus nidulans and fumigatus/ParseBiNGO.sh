#!/bin/bash
#csv file in the directory is now a variable for each iteration of the loop 
for FILE in *.csv; do
#new variable is now just the name of the csv (does not include ".csv")	
	NAME=$(echo $FILE | sed "s/....$//")
#make the file tab-delimited instead of comma-delimited	
	sed 's/,/	/g' $NAME.csv | \
#remove quotes around each value	
	sed 's/"//g' |\
#-F\t tells awk that these lines are tab-delimited and not space-delimited	
#print the first line (header)
#print the line if the second column (p-adjust) has a value that is less than or equal to 0.05	
	awk -F\t 'NR==1 || $2 <= 0.05' | \
#-v tells awk you are going to change its default settings
#OFS sets the output delimiter to tab	
	awk -v OFS='\t' -F\t '{print $5,$3,$2,$15,$14,$6,$4}' | \
#remove the dumb dos line breaks (^M in vi)	
	tr -d '\r' > $NAME.txt

done	
